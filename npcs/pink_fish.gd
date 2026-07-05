class_name Fish extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _on_body_entered(body: Fishy) -> void:
	body.make_bigger()
	animation_player.play("eat")
