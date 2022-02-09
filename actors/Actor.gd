# This file has been autogenerated by ts2gd. DO NOT EDIT!


extends ActorEquality
class_name Actor





var ActorEquality = load("res://actors/ActorEquality.gd")

const ActorType = {
  "None": 0x0,
  "Player": 0x1,
  "Goal": 0x2,
  "Enemy": 0x4,
}

const DamageMode = {
  "None": 0x0,
  "Deals": 0x1,
  "Takes": 0x2,
}


var isActivelyHandlingDamage setget , isActivelyHandlingDamage_get
var Sprite setget , Sprite_get
var Animations setget , Animations_get
var r315Prefix setget , r315Prefix_get
var r315HonorRotation setget , r315HonorRotation_get
var R315OrientationForRotation setget , R315OrientationForRotation_get
export(int, FLAGS, "Player", "Goal", "Enemy") var actorType = ActorType.None
export(int) var hitpoints: int = 100
export(int) var damage: int = 2
export(int, FLAGS, "Player", "Goal", "Enemy") var damageTakenFrom = ActorType.None
export(int, FLAGS, "Deals", "Takes") var damageMode = DamageMode.None
func isActivelyHandlingDamage_get():
  return not not self.damageMode

# @exports
# public hitSound: AudioStream | null = null;
func Sprite_get():
  return self.get_node("AnimatedSprite")
func Animations_get():
  return self.get_node("AnimationPlayer")

# public get Audio() {
#   return this.get_node("AudioPlayer");
# }
func _ready():
  self.inertia = INF
  self.Sprite.play("R000")
  self.contact_monitor = self.isActivelyHandlingDamage
func _process(_delta: float):
  self.r315HandleGraphics()
func _physics_process(_delta: float):
  self.r315HandleCollisions()
func r315Prefix_get():
  return ""
func r315HonorRotation_get():
  return true
func r315HandleGraphics():
  var sprite = self.Sprite
  
  var vel = self.linear_velocity.length()
  
  self.z_index = self.position.y
  if vel < 1:
    return sprite.stop()
  
  if not sprite.playing:
    sprite.play()
  
  var nextAnimation = self.r315Prefix + self.R315OrientationForRotation if self.r315HonorRotation else self.r315Prefix
  
  if nextAnimation != sprite.animation:
    sprite.play(nextAnimation)
func R315OrientationForRotation_get():
  var rot = self.linear_velocity.normalized().angle()
  
  if rot <= (-PI * 7) / 8:
    return "R180"
    
  
  else:
    if rot > (-PI * 7) / 8 and rot <= (-PI * 5) / 8:
      return "R135"
      
    
    else:
      if rot > (-PI * 5) / 8 and rot <= (-PI * 3) / 8:
        return "R090"
        
      
      else:
        if rot > (-PI * 3) / 8 and rot <= (-PI * 1) / 8:
          return "R045"
          
        
        else:
          if rot > (-PI * 1) / 8 and rot <= (PI * 1) / 8:
            return "R000"
            
          
          else:
            if rot > (PI * 1) / 8 and rot <= (PI * 3) / 8:
              return "R315"
              
            
            else:
              if rot > (PI * 3) / 8 and rot <= (PI * 5) / 8:
                return "R270"
                
              
              else:
                if rot > (PI * 5) / 8 and rot <= (PI * 7) / 8:
                  return "R225"
                  
                
                else:
                  if rot > (PI * 7) / 8:
                    return "R180"
                    
                  
                  else:
                    return "R000"
func r315HandleCollisions():
  if not self.isActivelyHandlingDamage:
    return
  
  for other in self.get_colliding_bodies():
    if not (other is ActorEquality):
      continue
    
    other = other
    if self.damageMode & DamageMode.Deals:
      self.potentiallyDealDamage(self, other)
    
    if self.damageMode & DamageMode.Takes:
      self.potentiallyDealDamage(other, self)
func potentiallyDealDamage(origin, target):
  if target.damageTakenFrom & origin.actorType:
    target.applyDamage(origin.damage, origin.actorType)
func applyDamage(amount: int, _from):
  self.hitpoints -= amount
  self.Animations.play("Hit")
  # if (this.hitSound) {
  #   this.Audio.play(this.hitSound, "hit")
  # }
  if self.hitpoints <= 0:
    self.queue_free()
