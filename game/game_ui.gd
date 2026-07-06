class_name GameUI extends Control

signal shop_pressed()

@onready var credits_label: Label = %CreditAmount
@onready var reputation_label: Label = %ReputationAmount

func _ready() -> void:
	GameManager.money_changed.connect(_on_money_update)

func _on_shop_button_pressed() -> void:
	shop_pressed.emit()

func _on_money_update(amount: int) -> void:
	credits_label.text = str(amount)

func _on_reputation_changed(amount: int) -> void:
	reputation_label.text = str(amount)
