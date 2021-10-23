extends Node2D

const Meteor = preload("res://scenes/Meteor.tscn")
const Helpers = preload("res://scripts/helpers.gd")
var is_table_active = false
onready var hud = $HUD
onready var hp_label = $HUD/Panel/HpLabel
onready var space_station = $SpaceStation
onready var meteor_platform_table = $MeteorPlatformTable


func _ready():
	refresh_hp_label()
	space_station.connect("hp_change", self, "_on_space_station_hp_change")
	# warning-ignore:return_value_discarded
	add_meteor(Vector2(100, 100), 300)
	# warning-ignore:return_value_discarded
	add_meteor(Vector2(100, 200), 200)


func _process(_delta) -> void:
	if Input.is_action_just_pressed("ui_up"):
		show_table()
	if Input.is_action_just_pressed("ui_down"):
		hide_table()


func _on_meteor_collision():
	space_station.hit(10)


func _on_space_station_hp_change(_hp: int) -> void:
	refresh_hp_label()


func add_meteor(pos: Vector2, v: int) -> KinematicBody2D:
	var m = Meteor.instance()
	m.connect("hit", self, "_on_meteor_collision")
	m.velocity = v
	m.global_position = pos
	add_child(m)
	return m


func refresh_hp_label() -> void:
	hp_label.text = "HP: %03d" % space_station.current_hp


func px_to_canon_coord(coord: Vector2) -> Vector2:
	return Helpers.px_to_canon_coord(coord, OS.window_size.y, hud.rect_size.y)


func canon_to_px_coord(coord: Vector2) -> Vector2:
	return Helpers.canon_to_px_coord(coord, OS.window_size.y, hud.rect_size.y)


func show_table() -> void:
	if is_table_active:
		return
	meteor_platform_table.rect_position.y -= meteor_platform_table.rect_size.y
	is_table_active = true


func hide_table():
	if not is_table_active:
		return
	meteor_platform_table.rect_position.y += meteor_platform_table.rect_size.y
	is_table_active = false


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
					val_1 = str(offsets[0])
					val_2 = "-"
				2:
					val_1 = str(offsets[0])
					val_2 = str(offsets[1])
				_:
					push_error("'offsets' is in wrong shape! ")

			var title = "M%s-P%s" % [m_i, p_i]
			res.append([title, val_1, val_2])

	return res
