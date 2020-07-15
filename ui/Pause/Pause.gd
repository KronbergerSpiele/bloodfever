extends Node2D

func _enter_tree():
	$Overlay.visible = false

func _ready():
	$Overlay.visible = false

func _onPauseButtonReleased():
	print("test")
	get_tree().set_input_as_handled()
