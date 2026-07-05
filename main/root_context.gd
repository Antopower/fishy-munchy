class_name RootContext extends Node

@export var menu_packed: PackedScene
@export var game_packed: PackedScene
@export var music_player_packed: PackedScene
@export var sfx_player_packed: PackedScene

var _music: MusicPlayer
var _sfx: SFXPlayer
var _config: ConfigContext

var current_scene: Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	build_services()
	setup()
	go_to_main_menu()
	
func build_services() -> void:
	_config = ConfigContext.new()
	add_child(_config)
	_music = music_player_packed.instantiate() as MusicPlayer
	add_child(_music)
	_sfx = sfx_player_packed.instantiate() as SFXPlayer
	add_child(_sfx)
	
func setup() -> void:
	AudioServer.set_bus_volume_linear(0, str(_config.get_value('audio', 'master_volume')).to_float())
	_music.volume_linear = _config.get_value('audio', 'music_volume')
	_sfx.volume_linear = _config.get_value('audio', 'sfx_volume')
	var display_mode: DisplayServer.WindowMode = _config.get_value('display', 'fullscreen')
	DisplayServer.window_set_mode(display_mode)
	if display_mode == 3:
		Input.mouse_mode = Input.MOUSE_MODE_CONFINED

func go_to_main_menu() -> void:
	if current_scene:
		current_scene.queue_free()
	current_scene = menu_packed.instantiate()
	add_child(current_scene)
	
	var menu_scene: MenuContext = current_scene as MenuContext
	if menu_scene:
		menu_scene.bind_services(_music, _sfx, _config)
		menu_scene.request_start_game.connect(handle_request_start_game)
		menu_scene.request_quit.connect(handle_request_quit)
		menu_scene.setup()
	
func handle_request_start_game() -> void:
	if current_scene:
		current_scene.queue_free()
	current_scene = game_packed.instantiate()
	add_child(current_scene)
	
	var game_scene: GameContext = current_scene as GameContext
	game_scene.bind_services(_music, _sfx, _config)
	game_scene.request_main_menu.connect(go_to_main_menu)
	game_scene.setup()
	
	_music.play_game_track()
	
func handle_request_settings() -> void:
	pass
	
func handle_request_quit() -> void:
	get_tree().quit()
