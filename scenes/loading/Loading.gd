extends Base
class_name Loading

@onready var timer: Timer = $Timer

func _ready():
	super._ready()
	timer.start()

func onTimerTimeout():
	switchTo("res://scenes/menu/Menu.tscn")
