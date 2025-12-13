extends Node2D
class_name Lifebar

@export var health: int = 100
@export var healthIncome: int = 0

@onready var bar = $Bar

func _process(_delta: float):
	health += healthIncome
	healthIncome = 0
	bar.value = health
