class_name SettingsMenu extends CanvasLayer

signal request_back()

@export var back_button: TextureButton
@export var master_volume_slider: HSlider
@export var music_volume_slider: HSlider
@export var effects_volume_slider: HSlider
@export var display_fullscreen_check: CheckButton

var _music: MusicPlayer
var _sfx: SFXPlayer
var _config: ConfigContext

func initialize(music: MusicPlayer, sfx: SFXPlayer, config: ConfigContext) -> void:
	_bind_services(music, sfx, config)
	_bind_events()
	_setup()

func _bind_services(music: MusicPlayer, sfx: SFXPlayer, config: ConfigContext) -> void:
	_music = music
	_sfx = sfx
	_config = config
	
func _bind_events() -> void:
	back_button.pressed.connect(on_press_back)
	master_volume_slider.value_changed.connect(update_master_volume)
	music_volume_slider.value_changed.connect(update_music_volume)
	effects_volume_slider.value_changed.connect(update_effects_volume)
	display_fullscreen_check.toggled.connect(update_display_fullscreen)

func _setup() -> void:
	master_volume_slider.value = AudioServer.get_bus_volume_linear(0) * 100
	music_volume_slider.value = _music.volume_linear * 100
	effects_volume_slider.value = _sfx.volume_linear * 100
	display_fullscreen_check.button_pressed = true if str(DisplayServer.window_get_mode()).to_int() == DisplayServer.WindowMode.WINDOW_MODE_FULLSCREEN else false

func on_press_back() -> void:
	request_back.emit()

func update_master_volume(value: float) -> void:
	AudioServer.set_bus_volume_linear(0, value / 100)
	_config.set_value('audio', 'master_volume', value / 100)

func update_music_volume(value: float) -> void:
	_music.volume_linear = value / 100
	_config.set_value('audio', 'music_volume', value / 100)

func update_effects_volume(value: float) -> void:
	_sfx.volume_linear = value / 100
	_config.set_value('audio', 'sfx_volume', value / 100)

func update_display_fullscreen(value: float) -> void:
	var input_mode: Input.MouseMode = Input.MOUSE_MODE_VISIBLE
	var display_mode: DisplayServer.WindowMode = DisplayServer.WINDOW_MODE_WINDOWED
	if value:
		display_mode = DisplayServer.WINDOW_MODE_FULLSCREEN
		input_mode = Input.MOUSE_MODE_CONFINED
	DisplayServer.window_set_mode(display_mode)
	Input.mouse_mode = input_mode
	_config.set_value('display', 'fullscreen', display_mode)
