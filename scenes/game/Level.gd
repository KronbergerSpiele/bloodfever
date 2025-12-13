extends Base
class_name Level

const ZombieTemplate = preload("res://actors/zombie/Zombie.tscn")

@onready var ui: CanvasLayer = $UI
@onready var draco: Actor = $actors/Draco
@onready var actors: Node = $actors
@onready var stick = $UI/Stick # Type 'Stick' not found in workspace, using loose typing or need class_name Stick
@onready var spawn_location: PathFollow2D = $SpawnPath/SpawnLocation

func _process(delta: float):
	super._process(delta)
	draco.linear_velocity = stick.output * 2

func onSpawnTimer():
	spawn_location.progress_ratio = nextRandom()
	var mob_instance = ZombieTemplate.instantiate()
	
	actors.add_child(mob_instance)
	mob_instance.position = spawn_location.position
