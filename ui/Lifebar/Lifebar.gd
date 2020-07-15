extends Node2D

export(int) var health = 100
export(int) var healthIncome = 0

func _process(delta):
	health += healthIncome
	healthIncome = 0
	$TextureProgress.value = health
