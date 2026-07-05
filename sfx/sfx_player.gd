class_name SFXPlayer extends AudioStreamPlayer

enum Key {
	SELECT
}

@export var sounds: Array[AudioStream]

func play_sound(key: SFXPlayer.Key) -> void:
	stream = sounds[int(key)]
	pitch_scale = randf_range(0.8, 1.2)
	play()
