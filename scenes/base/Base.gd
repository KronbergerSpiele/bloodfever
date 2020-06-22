extends Node2D

#func _enter_tree():

	#scale = Vector2(0,0)

func _ready():
	scale = Vector2(0,0)
	$AnimationPlayer.play("appear")
	print('base')

func switchTo(scene):
	$AnimationPlayer.play("disappear")
	yield($AnimationPlayer, "animation_finished")
	get_tree().change_scene(scene)
