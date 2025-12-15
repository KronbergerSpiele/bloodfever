extends Base
class_name Level

const ZombieTemplate = preload("res://actors/zombie/Zombie.tscn")

@onready var ui: CanvasLayer = $UI
@onready var draco: Actor = $actors/Draco
@onready var coffin = $actors/Coffin
@onready var actors: Node = $actors
@onready var stick = $UI/Stick # Type 'Stick' not found in workspace, using loose typing or need class_name Stick
@onready var spawn_location: PathFollow2D = $SpawnPath/SpawnLocation
@onready var lifebar: Lifebar = $Foreground/Lifebar
@onready var score_label: Label = $UI/ScoreLabel

var score: int = 0
const SCORE_PER_ZOMBIE: int = 10

func _ready():
    super._ready()
    # Set max health first so the bar scales correctly
    lifebar.set_max_health(coffin.hitpoints)
    
    coffin.health_changed.connect(on_coffin_health_changed)
    lifebar.health = coffin.hitpoints
    
    # Connect to all actors for death tracking
    for child in actors.get_children():
        if child is Actor:
            child.actor_died.connect(on_actor_died)
    
    update_score_display()

func _process(delta: float):
    super._process(delta)
    draco.linear_velocity = stick.output * 2

func onSpawnTimer():
    spawn_location.progress_ratio = nextRandom()
    var mob_instance = ZombieTemplate.instantiate()
    
    actors.add_child(mob_instance)
    mob_instance.position = spawn_location.position
    # Connect to track when this zombie dies
    mob_instance.actor_died.connect(on_actor_died)

func on_coffin_health_changed(new_health: float):
    lifebar.health = new_health

func on_actor_died(actor_type: int):
    if actor_type == Actor.ActorType.Enemy:
        score += SCORE_PER_ZOMBIE
        update_score_display()

func update_score_display():
    if score_label:
        score_label.text = str(score)
