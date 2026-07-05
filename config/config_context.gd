class_name ConfigContext extends Node

const CONFIG_PATH: String = "user://settings.cfg"
const DEFAULTS: Dictionary[StringName, Variant] = {
	"audio/master_volume": 1.0,
	"audio/music_volume": 1.0,
	"audio/sfx_volume": 1.0,
	"display/fullscreen": 0
}

var _config: ConfigFile = ConfigFile.new()

func _ready() -> void:
	load_config()

func load_config() -> void:
	var err: Error = _config.load(CONFIG_PATH)
	if err != OK:
		# No config file yet — use defaults
		reset_to_defaults()
		return

func save_config() -> void:
	_config.save(CONFIG_PATH)

func get_value(section: String, key: String) -> Variant:
	var default: Variant = DEFAULTS.get(section + "/" + key)
	return _config.get_value(section, key, default)

func set_value(section: String, key: String, value: float) -> void:
	_config.set_value(section, key, value)
	save_config()

func reset_to_defaults() -> void:
	for full_key: StringName in DEFAULTS:
		var parts: PackedStringArray = full_key.split("/")
		_config.set_value(parts[0], parts[1], DEFAULTS[full_key])
	save_config()
