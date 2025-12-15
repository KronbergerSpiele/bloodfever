extends Node2D
class_name Pause

@onready var overlay = $Overlay

func _ready():
	overlay.visible = false

func OnPauseButtonPressed():
	get_tree().paused = not get_tree().paused
	overlay.visible = get_tree().paused
	get_viewport().set_input_as_handled()

func OnContinueButtonPressed():
	get_tree().paused = false
	overlay.visible = false
	get_viewport().set_input_as_handled()
