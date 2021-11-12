extends "res://scripts/BaseLevel.gd"

var dialog = Dialogic.start("Tutorial")


func _ready() -> void:
	add_child(dialog)
	dialog.connect("dialogic_signal", self, "dialog_handler")


func dialog_handler(value: String) -> void:
	match value:
		"goto_config": handle_overlay("config")
		"goto_forecast": handle_overlay("forecast")
		"goto_collidix": handle_overlay("collidix")
		"goto_confirm": handle_overlay("confirm")
		"hide_overlay": hide_overlay()
