# This file has been autogenerated by ts2gd. DO NOT EDIT!


extends Base
class_name Level




func mul_vec_lib(v1, v2):
  return null if (v1 == null or v2 == null) else v1 * v2



var Base = load("res://scenes/Base.gd")


var UI setget , UI_get
var Draco setget , Draco_get
var Actors setget , Actors_get
var Stick setget , Stick_get
var spawnLocation setget , spawnLocation_get
var ZombieTemplate = load("res://actors/zombie/Zombie.tscn")
func UI_get():
  return self.get_node("UI")
func Draco_get():
  return self.get_node("actors/Draco")
func Actors_get():
  return self.get_node("actors")
func Stick_get():
  return self.get_node("UI/Stick")
func spawnLocation_get():
  return self.get_node("SpawnPath/SpawnLocation")
func _process(_delta: float):
  self.Draco.linear_velocity = mul_vec_lib(self.Stick.output, 2)
func onSpawnTimer():
  self.spawnLocation.unit_offset = self.nextRandom()
  var mobInstance = self.ZombieTemplate.instance()
  
  self.Actors.add_child(mobInstance)
  mobInstance.position = self.spawnLocation.position
