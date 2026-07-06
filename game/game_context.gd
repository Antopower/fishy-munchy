class_name GameContext extends Node2D

signal request_main_menu

@export var game_menu_packed: PackedScene
@export var map_packed: PackedScene
@export var upgrade_menu_packed: PackedScene
@export var game_ui: GameUI

var _music: MusicPlayer
var _sfx: SFXPlayer
var _config: ConfigContext

var currrent_scenario: Node2D

func bind_services(music: MusicPlayer, sfx: SFXPlayer, config: ConfigContext) -> void:
	_music = music
	_sfx = sfx
	_config = config

func setup() -> void:
	currrent_scenario = map_packed.instantiate()
	var map: Map = currrent_scenario as Map
	map.on_game_over.connect(toggle_upgrade_menu)
	add_child(currrent_scenario)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("game_menu"):
		toggle_game_menu()
	if event.is_action_pressed("upgrade_menu"):
		toggle_upgrade_menu()

func toggle_game_menu() -> void:
	if $UI.has_node("GameMenu"):
		$UI.get_node('GameMenu').queue_free()
		if !GameManager.is_game_over():
			currrent_scenario.set_process_mode(PROCESS_MODE_ALWAYS)
	else:
		var game_menu: GameMenu = game_menu_packed.instantiate()
		game_menu.exit_pressed.connect(handle_request_main_menu)
		$UI.add_child(game_menu)
		currrent_scenario.set_process_mode(PROCESS_MODE_DISABLED)

func toggle_upgrade_menu() -> void:
	if $UI.has_node("UpgradeMenu"):
		$UI.get_node('UpgradeMenu').queue_free()
	else:
		var upgrade_menu: UpgradeMenu = upgrade_menu_packed.instantiate()
		upgrade_menu.on_continue_game.connect(handle_continue_after_upgrade)
		$UI.add_child(upgrade_menu)

func handle_continue_after_upgrade() -> void:
	toggle_upgrade_menu()
	currrent_scenario.reset_level()
	currrent_scenario.set_process_mode(PROCESS_MODE_ALWAYS)
	
func handle_request_main_menu() -> void:
	request_main_menu.emit()
