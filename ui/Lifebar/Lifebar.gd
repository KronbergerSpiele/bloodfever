# This file has been autogenerated by ts2gd. DO NOT EDIT!


extends Node2D
class_name Lifebar







var Bar setget , Bar_get
export(int) var health: int = 100
export(int) var healthIncome: int = 0
func Bar_get():
  return self.get_node("Bar")
func _process(_delta: float):
  self.health += self.healthIncome
  self.healthIncome = 0
  self.Bar.value = self.health

