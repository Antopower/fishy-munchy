class_name Fishy extends CharacterBody2D

signal died

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var timer: Timer = $Timer
@onready var fishy_finder: ColorRect = $FishyFinder

var boosting: float = 1

func _ready() -> void:
	timer.wait_time = GameManager.fishy_decay_speed
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("boost", true):
		boosting = 3
	elif event.is_action_released("boost", true):
		boosting = 1

func _physics_process(_delta: float) -> void:
	var speed: float = GameManager.fishy_speed * boosting
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction_x: float  = Input.get_axis("move_left", "move_right")
	
	if direction_x > 0:
		animated_sprite.flip_h = false
	elif direction_x < 0:
		animated_sprite.flip_h = true
	
	if direction_x:
		velocity.x = direction_x * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction_y: float = Input.get_axis("move_top", "move_bottom")
	if direction_y:
		velocity.y = direction_y * speed
	else:
		velocity.y = move_toward(velocity.y, 0, speed)

	move_and_slide()

func make_bigger() -> void:
	GameManager.add_money(GameManager.enemy_value)
	if scale > Vector2(5, 5):
		return
	scale += GameManager.fishy_scale_up
	if scale > Vector2(0.5, 0.5):
		fishy_finder.visible = false

func make_smaller() -> void:
	scale -= GameManager.fishy_scale_down
	if scale <= Vector2(0.1, 0.1):
		scale = Vector2(0, 0)
		fishy_finder.visible = false
		die()
	if scale <= Vector2(0.5, 0.5):
		fishy_finder.visible = true

func die() -> void:
	died.emit()

func _on_timer_timeout() -> void:
	timer.wait_time = GameManager.fishy_decay_speed
	make_smaller()
