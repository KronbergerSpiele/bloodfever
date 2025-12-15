extends Actor

@export var move_speed: float = 30.0

func _ready():
    super._ready()
    actorType = ActorType.Enemy
    damageMode = DamageMode.Deals | DamageMode.Takes
    damageTakenFrom = ActorType.Player

func _physics_process(delta):
    super._physics_process(delta)
    
    var goals = get_tree().get_nodes_in_group("Goal")
    if goals.size() > 0:
        var target = goals[0]
        var direction = (target.global_position - global_position).normalized()
        linear_velocity = direction * move_speed
