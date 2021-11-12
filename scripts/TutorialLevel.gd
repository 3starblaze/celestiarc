extends "res://scripts/BaseLevel.gd"

var dialog = Dialogic.start("Tutorial")


func _ready() -> void:
	add_child(dialog)
	dialog.connect("dialogic_signal", self, "dialog_handler")


func dialog_handler(value: String) -> void:
	match value:
		"foo": print("foo-tastic")
