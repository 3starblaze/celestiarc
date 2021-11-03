extends Control

const IconifiedTextInfo = preload("res://scripts/IconifiedTextInfo.gd")
const ArrowsCounterClockwiseIcon = preload("res://assets/phospor-icons/arrows-counter-clockwise.png")
var queued_lines = [] # Lines that are about to be printed to the shell
onready var table = $Panel/VBoxContainer/Content/Wrapper/Wrapper/CollidixTable
onready var calculate_button = $Panel/VBoxContainer/Content/Wrapper/CalculateButton
onready var shell_label = $Panel/VBoxContainer/Content/Wrapper/Wrapper/ShellBackground/ScrollContainer/Text


func _ready() -> void:
	calculate_button.connect("pressed", self, "_calculate_button_pressed")
	table.visible = false
	shell_label.text = ""
	for line in ["$ calc", "calculating..."]:
		shell_write_line(line)


func _calculate_button_pressed() -> void:
	for line in queued_lines:
		shell_write_line(line)
	queued_lines = []
	table.visible = true


func gen_meteor_platform_table_data(meteors: Array, platforms: Array) -> Array:
	var res = []
	for p_i in platforms.size():
		for m_i in meteors.size():
			var offsets = Helpers.simple_calculate_rotational_offset(
				meteors[m_i],
				platforms[p_i]
			)
			var val_1 = ""
			var val_2 = ""
			match offsets.size():
				0:
					val_1 = "-"
					val_2 = "-"
				1:
					val_1 = Helpers.f_round_fmt(offsets[0])
					val_2 = "-"
				2:
					val_1 = Helpers.f_round_fmt(offsets[0])
					val_2 = Helpers.f_round_fmt(offsets[1])
				_:
					push_error("'offsets' is in wrong shape! ")

			var title = "M%s-P%s" % [m_i + 1, p_i + 1]
			res.append([title, val_1, val_2])

	return res


func _process_table_data(data: Array):
	for row in data:
		for cell in row:
			table.add_cell(cell)


func gen_table(meteor_arr: Array, platform_arr: Array) -> void:
	var col_info = [
		IconifiedTextInfo.new("Angle 1", ArrowsCounterClockwiseIcon),
		IconifiedTextInfo.new("Angle 2", ArrowsCounterClockwiseIcon),
	]
	table.setup_table(col_info)
	table.set_title("Angles")
	_process_table_data(
		gen_meteor_platform_table_data(meteor_arr, platform_arr)
	)
	queued_lines = shell_line_gen(meteor_arr, platform_arr)


func shell_write_line(line: String) -> void:
	"""Add a string and a newline to shell label."""
	shell_label.text += line + "\n"


func shell_line_gen(meteor_arr: Array, platform_arr: Array) -> Array:
	var lines = ["Reading data..."]
	for i in range(meteor_arr.size()):
		var prefix = "M%d_" % (i + 1)
		var m = meteor_arr[i]
		lines.append(prefix + "velocity = %s" % Helpers.f_round_fmt(m.velocity))
		lines.append(prefix + "position = %s"
			% Helpers.v2_round_fmt(m.canon_coord)
		)

	for i in range(platform_arr.size()):
		var prefix = "P%d_" % (i + 1)
		var p = platform_arr[i]
		lines.append(prefix + "origin_position = %s"
			% Helpers.v2_round_fmt(p.canon_coord)
		)
		lines.append(prefix + "radius = %s" % Helpers.f_round_fmt(p.radius))
		lines.append(prefix + "omega = %s"
			% Helpers.f_round_fmt(p.rotational_offset)
		)

	return lines
