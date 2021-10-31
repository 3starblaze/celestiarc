extends Control

onready var next_level_button = $Panel/VBoxContainer/Content/VBoxContainer/NextLevelButton


func _ready() -> void:
	next_level_button.connect("pressed", self, "_on_next_level_button_pressed")


func _on_next_level_button_pressed() -> void:
	Globals.emit_signal("next_level")
