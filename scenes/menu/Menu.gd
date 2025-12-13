extends Base
class_name Menu

func onStartPressed():
	switchTo("res://scenes/game/Diner.tscn")

func onAboutPressed():
	switchTo("res://scenes/about/About.tscn")
