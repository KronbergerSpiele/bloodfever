extends Node2D

#func _enter_tree():

	#scale = Vector2(0,0)

func _ready():
	$lastScene.texture = Global.lastSceneSnapshot
	$lastScene.scale = Vector2(1,1)
	$lastSceneAnimation.play("disappear")
	print(Global.lastSceneSnapshot)

func switchTo(scene):
	var img = get_viewport().get_texture().get_data()
	img.flip_y()
	var tex = ImageTexture.new()
	tex.create_from_image(img)
	Global.lastSceneSnapshot = tex
	
	get_tree().change_scene(scene)
