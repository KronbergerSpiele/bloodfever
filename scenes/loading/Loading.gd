extends "res://scenes/base/Base.gd"

func _ready():
	$Timer.start()

func _on_Timer_timeout():
	switchTo("res://scenes/menu/Menu.tscn")
