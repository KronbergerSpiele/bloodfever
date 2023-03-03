extends Base
class_name Level

var ZombieTemplate = load("res://actors/zombie/Zombie.tscn")

func UI() -> CanvasLayer:
  return $UI as CanvasLayer

func Draco() -> Actor:
  return $actors/Draco as Actor

func Actors() -> Node:
  return $actors

func Stick() -> Stick:
  return $UI/Stick as Stick

func SpawnLocation() -> PathFollow2D:
  return $SpawnPath/SpawnLocation as PathFollow2D

func _process(_delta: float):
  self.Draco().linear_velocity = self.Stick().output * 2

func onSpawnTimer():
  self.SpawnLocation().progress_ratio = self.nextRandom()
  var mobInstance = self.ZombieTemplate.instantiate()
  
  self.Actors().add_child(mobInstance)
  mobInstance.position = self.SpawnLocation().position
