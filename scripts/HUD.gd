extends Control

onready var hp_label = $Panel/HBoxContainer/HpLabel


func set_hp_label(hp: int) -> void:
	hp_label.text = "HP: %03d" % hp
