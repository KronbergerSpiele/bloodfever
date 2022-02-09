extends ActorEquality
class_name Actor

enum ActorType {
  None= 0x0,
  Player= 0x1,
  Goal= 0x2,
  Enemy= 0x4,
}

enum DamageMode {
  None = 0x0,
  Deals = 0x1,
  Takes = 0x2,
}

export(int, FLAGS, "Player", "Goal", "Enemy") var actorType = ActorType.None
export(int, FLAGS, "Player", "Goal", "Enemy") var damageTakenFrom = ActorType.None
export(int, FLAGS, "Deals", "Takes") var damageMode = DamageMode.None
export(int) var hitpoints: int = 100
export(int) var damage: int = 2

func Sprite() -> AnimatedSprite:
  return $AnimatedSprite as AnimatedSprite
  
func Animations() -> AnimationPlayer:
  return $AnimationPlayer as AnimationPlayer

func Audio() -> AudioStreamPlayer2D:
  return $AudioPlayer as AudioStreamPlayer2D

func _ready():
  self.inertia = INF
  self.Sprite().play("R000")
  self.contact_monitor = self.isActivelyHandlingDamage()

func _process(_delta: float):
  self.r315HandleGraphics()

func _physics_process(_delta: float):
  self.r315HandleCollisions()

func isActivelyHandlingDamage():
  return not not self.damageMode

func r315Prefix():
  return ""

func r315HonorRotation():
  return true

func r315HandleGraphics():
  var sprite = self.Sprite()  
  var vel = self.linear_velocity.length()
  
  self.z_index = self.position.y
  if vel < 1:
    return sprite.stop()
  
  if not sprite.playing:
    sprite.play()
  
  var nextAnimation = self.r315Prefix() + self.R315OrientationForRotation() if self.r315HonorRotation() else self.r315Prefix()
  
  if nextAnimation != sprite.animation:
    sprite.play(nextAnimation)

func R315OrientationForRotation():
  var rot = self.linear_velocity.normalized().angle()
  
  if rot <= (-PI * 7) / 8:
    return "R180"
  elif rot > (-PI * 7) / 8 and rot <= (-PI * 5) / 8:
    return "R135"
  elif rot > (-PI * 5) / 8 and rot <= (-PI * 3) / 8:
    return "R090"
  elif rot > (-PI * 3) / 8 and rot <= (-PI * 1) / 8:
    return "R045"
  elif rot > (-PI * 1) / 8 and rot <= (PI * 1) / 8:
    return "R000"
  elif rot > (PI * 1) / 8 and rot <= (PI * 3) / 8:
    return "R315"
  elif rot > (PI * 3) / 8 and rot <= (PI * 5) / 8:
    return "R270"
  elif rot > (PI * 5) / 8 and rot <= (PI * 7) / 8:
    return "R225"
  elif rot > (PI * 7) / 8:
    return "R180"
  else:
    return "R000"

func r315HandleCollisions():
  if not self.isActivelyHandlingDamage():
    return
  
  for other in self.get_colliding_bodies():
    if not (other is ActorEquality):
      continue
      
    if self.damageMode & DamageMode.Deals:
      self.potentiallyDealDamage(self, other)
    if self.damageMode & DamageMode.Takes:
      self.potentiallyDealDamage(other, self)

func potentiallyDealDamage(origin, target):
  if target.damageTakenFrom & origin.actorType:
    target.applyDamage(origin.damage, origin.actorType)

func applyDamage(amount: int, _from):
  self.hitpoints -= amount
  self.Animations().play("Hit")
  # if (this.hitSound) {
  #   this.Audio.play(this.hitSound, "hit")
  # }
  if self.hitpoints <= 0:
    self.queue_free()

