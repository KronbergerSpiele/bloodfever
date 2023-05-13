extends Base
class_name Menu

func onStartPressed():
  self.switchTo("res://scenes/game/Diner.tscn")

func onAboutPressed():
  self.switchTo("res://scenes/about/About.tscn")
