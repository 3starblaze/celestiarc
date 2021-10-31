extends Control

const IconifiedText = preload("res://scenes/IconifiedText.tscn")
var column_names = []
var item_row_count = 0 # How many rows (except title row) are there
onready var table_grid = $VBoxContainer/TableGrid
onready var table_title = $VBoxContainer/Title


func _ready() -> void:
	set_title("Code-crafted table")
	register_column("Prop Foo")
	register_column("Prop Bar")
	register_column("Prop Baz")
	register_column("Prop Qux")
	_setup_table()
	add_row()
	add_row()
	add_row()


func _setup_table() -> void:
	Helpers.kill_children(table_grid)
	table_grid.columns = get_column_count() + 1
	table_grid.add_child(MarginContainer.new()) # Blank cell
	for name in column_names:
		var label = IconifiedText.instance()
		label.get_node("Label").text = name
		table_grid.add_child(label)


func set_title(value: String) -> void:
	table_title.text = value


func add_row() -> void:
	var n = item_row_count + 1
	table_grid.add_child(Helpers._create_label(gen_col_name(n)))
	# +1 to range because the 0th item in a row is the column name
	for i in range(1, get_column_count() + 1):
		table_grid.add_child(Helpers._create_label(gen_value(i, n)))
	item_row_count = n


func register_column(name: String) -> void:
	"""Create a column called `name`"""
	column_names.append(name)


func get_column_count() -> int:
	return column_names.size()


func gen_col_name(i: int) -> String:
	"""Given index i, create column name, i.e. the first item in the row.

	Note: Since the 0th row is for titles and top-left cell is blank, indexing
	starts from 1."""
	return "Item %s" % i


func gen_value(col: int, row: int) -> String:
	"""Given indices col and row, return value to be inserted in the table."""
	return "COL%s-ROW%s" % [col, row]
