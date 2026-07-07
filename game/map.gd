class_name Map extends Node2D

signal on_game_over

@export var possible_fishes: Array[PackedScene]

@onready var fishes_container: Node2D = $Fishes
@onready var player: Fishy = $Player

var new_spawn: float = 1
var spawn_timer: float = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	spawn_timer += delta 
	if spawn_timer > new_spawn:
		spawn_new_fish()

func _on_player_died() -> void:
	GameManager.set_game_over(true)
	on_game_over.emit()
	self.set_process_mode(PROCESS_MODE_DISABLED)
	
func reset_level() -> void:
	player.scale = Vector2(1, 1)
	GameManager.set_game_over(false)
	self.set_process_mode(PROCESS_MODE_ALWAYS)
	
func spawn_new_fish() -> void:
	# Reset spawn timer
	new_spawn = randf_range(GameManager.spawn_time_range.x, GameManager.spawn_time_range.y)
	spawn_timer = 0

	# Spawn new fish
	var new_fish_type: PackedScene = possible_fishes.pick_random()
	var new_fish: Fish = new_fish_type.instantiate()
	fishes_container.add_child(new_fish)
