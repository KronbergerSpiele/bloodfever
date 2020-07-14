extends Node2D

func _ready():
	pass

func _process(delta):
	$actors/Draco.linear_velocity = $Stick.output * 2
