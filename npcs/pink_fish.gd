class_name Fish extends Area2D


const SPAWN_HEIGHT_VALUES: Vector2i = Vector2i(10, 700)
const SPAWN_SIDE_VALUES: Array[float] = [-100.0, 1380.0]
const POSSIBLE_SIDES: Array[int] = [0, 1]

var spawn_side: int
var swim_speed: float

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	swim_speed = randf_range(GameManager.enemy_speed.x, GameManager.enemy_speed.y)
	spawn_side = POSSIBLE_SIDES.pick_random()
	position = Vector2(SPAWN_SIDE_VALUES[spawn_side], randi_range(SPAWN_HEIGHT_VALUES.x, SPAWN_HEIGHT_VALUES.y))

func _physics_process(delta: float) -> void:
	if position.x < SPAWN_SIDE_VALUES[0] or position.x > SPAWN_SIDE_VALUES[1]:
		queue_free()
	if spawn_side == 0:
		position = Vector2(position.x + swim_speed * delta, position.y)
	else:
		position = Vector2(position.x - swim_speed * delta, position.y)

func _on_body_entered(body: Node2D) -> void:
	if body.is_class("CharacterBody2D"):
		body.make_bigger()
	animation_player.play("eat")
