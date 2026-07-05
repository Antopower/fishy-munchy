class_name MainMenu extends CanvasLayer

signal request_start_game()
signal request_settings()
signal request_quit()

@export var start_button: TextureButton
@export var settings_button: TextureButton
@export var quit_button: TextureButton
	
func bind_events() -> void:
	start_button.pressed.connect(on_press_start)
	settings_button.pressed.connect(on_press_settings)
	quit_button.pressed.connect(on_press_quit)
	
func on_press_start() -> void:
	#_sfx.request_sound(SFXPlayer.Key.SELECT)
	request_start_game.emit()

func on_press_settings() -> void:
	#_sfx.request_sound(SFXPlayer.Key.SELECT)
	request_settings.emit()
	hide()

func on_press_quit() -> void:
	#_sfx.request_sound(SFXPlayer.Key.SELECT)
	request_quit.emit()
