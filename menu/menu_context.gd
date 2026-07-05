class_name MenuContext extends Node

signal request_start_game()
signal request_quit()

@export var main_menu_packed: PackedScene
@export var settings_menu_packed: PackedScene

var _music: MusicPlayer
var _sfx: SFXPlayer
var _config: ConfigContext

var main_menu_scene: MainMenu
var settings_scene: SettingsMenu

func bind_services(music: MusicPlayer, sfx: SFXPlayer, config: ConfigContext) -> void:
	_music = music
	_sfx = sfx
	_config = config

func setup() -> void:
	_music.play_menu_track()
	main_menu_scene = main_menu_packed.instantiate()
	add_child(main_menu_scene)
	
	var main_menu: MainMenu = main_menu_scene as MainMenu
	if main_menu:
		main_menu.bind_events()
		main_menu.request_start_game.connect(on_press_start)
		main_menu.request_settings.connect(on_press_settings)
		main_menu.request_quit.connect(on_press_quit)
	
func on_press_start() -> void:
	_sfx.play_sound(SFXPlayer.Key.SELECT)
	request_start_game.emit()
	
func on_press_settings() -> void:
	_sfx.play_sound(SFXPlayer.Key.SELECT)
	settings_scene = settings_menu_packed.instantiate()
	add_child(settings_scene)
	var settings_menu: SettingsMenu = settings_scene as SettingsMenu
	if settings_menu:
		settings_menu.initialize(_music, _sfx, _config)
		settings_menu.request_back.connect(on_close_settings)
		
func on_close_settings() -> void:
	settings_scene.queue_free()
	main_menu_scene.visible = true

func on_press_quit() -> void:
	_sfx.play_sound(SFXPlayer.Key.SELECT)
	request_quit.emit()
