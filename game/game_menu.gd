class_name GameMenu extends Control

signal settings_pressed(origin: String)
signal exit_pressed()

func _on_settings_pressed() -> void:
	settings_pressed.emit("game_menu")

func _on_exit_pressed() -> void:
	exit_pressed.emit()
