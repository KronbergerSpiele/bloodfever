extends Base
class_name Loading

func Timer() -> Timer:
  return $Timer as Timer

func _ready():
  self.Timer().start()

func onTimerTimeout():
  self.switchTo("res://scenes/menu/Menu.tscn")

