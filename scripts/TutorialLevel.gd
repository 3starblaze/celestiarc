extends "res://scripts/BaseLevel.gd"

var dialog = Dialogic.start("Tutorial")


func _ready() -> void:
	add_child(dialog)
	dialog.connect("dialogic_signal", self, "dialog_handler")


func _handle_win() -> void:
	add_child(Dialogic.start("Tutorial after win"))


func dialog_handler(value: String) -> void:
	match value:
		"goto_config": handle_overlay("config")
		"goto_forecast": handle_overlay("forecast")
		"goto_collidix": handle_overlay("collidix")
		"goto_confirm": handle_overlay("confirm")
		"hide_overlay": hide_overlay()
		"start_calculation": Globals.emit_signal("start_calculation")
		"configure_p1":
			Globals.emit_signal("change_platform_config", 0, "0.7023")
		"configure_p2":
			Globals.emit_signal("change_platform_config", 1, "5.5099")
		"confirm_level":
			_on_confirmed()
		"finished":
			dialog.queue_free()
			Globals.connect("win", self, "_handle_win")
