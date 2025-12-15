extends Actor

signal health_changed(new_health)

var is_dead = false

func _ready():
    super._ready()
    actorType = ActorType.Goal
    damageMode = DamageMode.Takes
    damageTakenFrom = ActorType.Enemy
    add_to_group("Goal")

func apply_damage(amount: float, from_type):
    super.apply_damage(amount, from_type)
    emit_signal("health_changed", hitpoints)
    if hitpoints <= 0 and not is_dead:
        is_dead = true
        # Game Over - Restart Level for now
        # Use call_deferred to ensure it happens after physics frame
        # and check if tree is still valid
        var tree = get_tree()
        if tree:
            tree.call_deferred("reload_current_scene")
