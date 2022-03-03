extends Base
class_name Menu

func onStartPressed():
  self.switchTo("res://scenes/game/Diner.tscn")
  self.Global().JSGD().reportScore(111)

func onAboutPressed():
  self.switchTo("res://scenes/about/About.tscn")
