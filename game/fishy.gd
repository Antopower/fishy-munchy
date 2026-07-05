class_name Fishy extends CharacterBody2D

signal died

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

const SPEED = 100.0

func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction_x := Input.get_axis("move_left", "move_right")
	
	if direction_x > 0:
		animated_sprite.flip_h = false
	elif direction_x < 0:
		animated_sprite.flip_h = true
	
	if direction_x:
		velocity.x = direction_x * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction_y := Input.get_axis("move_top", "move_bottom")
	if direction_y:
		velocity.y = direction_y * SPEED
	else:
		velocity.y = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func make_bigger() -> void:
	scale += Vector2(0.1, 0.1)

func make_smaller() -> void:
	scale -= Vector2(0.1, 0.1)

func die() -> void:
	died.emit()

func _on_timer_timeout() -> void:
	make_smaller()
