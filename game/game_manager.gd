extends Node

signal money_changed

var game_over: bool = false

# Economy
var money: int = 0

# Enemies Stats
var spawn_time_range: Vector2 = Vector2(1, 3)
var enemy_speed: Vector2 = Vector2(150, 250)
var enemy_value: int = 10

# Fishy Stats
var fishy_speed: float = 200.0
var fishy_decay_speed: float = 2
var fishy_scale_up: Vector2 = Vector2(0.1, 0.1)
var fishy_scale_down: Vector2 = Vector2(0.2, 0.2)
	
func set_game_over(status: bool) -> void:
	game_over = status
	
func is_game_over() -> bool:
	return game_over

func add_money(amount: int) -> int:
	money += amount
	
	money_changed.emit(money)

	return money
	
func reduce_money(amount: int) -> int:
	if amount > money:
		return amount
	money -= amount

	money_changed.emit(money)

	return money
