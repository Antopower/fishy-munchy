class_name UpgradeMenu extends Control

signal on_continue_game
# signal on_save_quit_game

func _on_upgrade_speed_pressed() -> void:
	var upgrade_price: int = 20
	if !can_buy(upgrade_price):
		return
		
	GameManager.reduce_money(upgrade_price)
	GameManager.fishy_speed += 100


func _on_upgrade_spawn_pressed() -> void:
	var upgrade_price: int = 50
	if !can_buy(upgrade_price):
		return
	var current_value: Vector2 = GameManager.spawn_time_range
	var new_value: Vector2 = current_value - Vector2(0.1, 0.1)

	GameManager.reduce_money(upgrade_price)
	if new_value <= Vector2(0.1, 0.1) : 
		GameManager.spawn_time_range = Vector2(0.1, 0.1)
	else:
		GameManager.spawn_time_range = new_value

func _on_upgrade_ultra_spawn_pressed() -> void:
	var upgrade_price: int = 150
	if !can_buy(upgrade_price):
		return
	GameManager.reduce_money(upgrade_price)
	GameManager.spawn_time_range = Vector2(0.001, 0.003)

func can_buy(price: int) -> bool:
	return true if GameManager.money >= price else false


func _on_continue_pressed() -> void:
	on_continue_game.emit()
