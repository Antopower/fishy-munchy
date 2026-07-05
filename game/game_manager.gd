extends Node

var current_game_scene: Node = null
var is_game_menu_opened: bool = false

func _unhandled_input(event: InputEvent) -> void:
	if current_game_scene:
		if event.is_action_pressed("game_menu"):
			current_game_scene.toggle_game_menu()
		if event.is_action_pressed("shop_menu"):
			current_game_scene.toggle_shop_menu()
