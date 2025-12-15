extends ActorEquality
class_name Actor

signal actor_died(actor_type: int)

enum ActorType {
    None = 0x0,
    Player = 0x1,
    Goal = 0x2,
    Enemy = 0x4,
}

enum DamageMode {
    None = 0x0,
    Deals = 0x1,
    Takes = 0x2,
}

@export_flags("Player", "Goal", "Enemy") var actorType: int = ActorType.None
@export_flags("Player", "Goal", "Enemy") var damageTakenFrom: int = ActorType.None
@export_flags("Deals", "Takes") var damageMode: int = DamageMode.None
@export var hitpoints: float = 100.0
@export var damage: float = 2.0
@export var hitSound: AudioStream

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var animations: AnimationPlayer = $AnimationPlayer
@onready var audio: LocalAudio = $LocalAudio

func _ready():
    # Godot 4: Use freeze_mode and lock_rotation instead of inertia
    lock_rotation = true
    # inertia = INF # Not strictly necessary for locking rotation in Godot 4
    
    
    # sprite.play("R000") # moved to _handle_graphics logic usually, but fine here
    
    contact_monitor = damageMode != DamageMode.None
    max_contacts_reported = 10 # Required for contact_monitor


func _process(_delta: float):
    _handle_graphics()

func _physics_process(_delta: float):
    _handle_collisions()

func _handle_graphics():
    var vel_len = linear_velocity.length()
    
    # z_index handled by y_sort_enabled on actors container
    if vel_len < 1:
        sprite.stop()
        return
    
    if not sprite.is_playing():
        sprite.play()
    
    var prefix = _get_animation_prefix()
    var anim_name = prefix
    
    if _honor_rotation():
        anim_name += _get_orientation_for_rotation()
    
    if anim_name != sprite.animation:
        sprite.play(anim_name)

func _get_animation_prefix() -> String:
    return ""

func _honor_rotation() -> bool:
    return true

func _get_orientation_for_rotation() -> String:
    var rot = linear_velocity.angle()
    # Map angle to 0-7 index. 0 = Right, clockwise positive.
    # PI/4 = Down-Right (R315 in 360 deg CCW terms? No, R315 is -45 deg)
    # Original code mapped PI/4 (Down-Right) to "R315". 
    # "R315" likely means 315 degrees (CCW from East), which is -45 degrees (Down-Right).
    
    var index = int(round(rot / (PI / 4.0)))
    var directions = ["R000", "R315", "R270", "R225", "R180", "R135", "R090", "R045"]
    return directions[posmod(index, 8)]

func _handle_collisions():
    if damageMode == DamageMode.None:
        return
    
    # Debug: Print contacts if any
    # var contacts = get_colliding_bodies()
    # if contacts.size() > 0:
    #    print("Contacts: ", contacts.size())

    for other in get_colliding_bodies():
        # IMPORTANT: Godot 4 requires checking Node/Object type properly
        if not (other is ActorEquality):
            continue
            
        if damageMode & DamageMode.Deals:
            _potentially_deal_damage(self, other)
        if damageMode & DamageMode.Takes:
            _potentially_deal_damage(other, self)

func _potentially_deal_damage(origin, target):
    # Fix: Use bitwise AND and check if result > 0
    if (target.damageTakenFrom & origin.actorType) > 0:
        # Cast to float to avoid potential type issues if damage comes from int source
        target.apply_damage(float(origin.damage), origin.actorType)

func apply_damage(amount: float, _from):
    hitpoints -= amount
    if animations.has_animation("Hit"):
        animations.play("Hit")
    if hitSound:
        audio.play(hitSound)
    
    if hitpoints <= 0:
        emit_signal("actor_died", actorType)
        queue_free()
