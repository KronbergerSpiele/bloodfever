extends Node2D

export var FrontTexture: ImageTexture
export var BackTexture: ImageTexture

func _process(_delta):
	var texture = $Viewport.get_texture()
	$screen.texture = texture
