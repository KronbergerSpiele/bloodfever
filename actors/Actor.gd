extends RigidBody2D
class_name Actor

export(int) var hitpoints = 100
export(int) var damage = 2

var touchingBodies = []

func _init():
	inertia = INF

func _ready():
	$AnimatedSprite.play('R000')

func _process(_delta: float):
	r315HandleGraphics()
	r315HandleCollisions()

func r315HandleCollisions():
	pass

func r315HandleGraphics() -> void:
	var vel = linear_velocity.length()
	z_index = position.y
	if vel < 1:
		$AnimatedSprite.stop()
	else:
		if !$AnimatedSprite.playing:
			$AnimatedSprite.play()
		var rotation = linear_velocity.normalized().angle()
		var nextAnimation = r315Prefix()
		if r315HonorRotation():
			nextAnimation += r315OrientationForRotation(rotation)
		if $AnimatedSprite.animation != nextAnimation:
			$AnimatedSprite.play(nextAnimation)

func r315OrientationForRotation(rotation: float) -> String:
	if rotation <= - PI * 7 / 8:
		return "R180"
	elif rotation > - PI * 7 / 8 and rotation <= - PI * 5 / 8:
		return "R135"
	elif rotation > - PI * 5 / 8 and rotation <= - PI * 3 / 8:
		return "R090"
	elif rotation > - PI * 3 / 8 and rotation <= - PI * 1 / 8:
		return "R045"
	elif rotation > - PI * 1 / 8 and 	rotation <= PI * 1 / 8:
		return "R000"
	elif rotation > PI * 1 / 8 and rotation <= PI * 3 / 8:
		return "R315"
	elif rotation > PI * 3 / 8 and rotation <= PI * 5 / 8:
		return "R270"
	elif rotation > PI * 5 / 8 and rotation <= PI * 7 / 8:
		return "R225"
	elif rotation > PI * 7 / 8:
		return "R180"
	else:
		return "R000"

func r315Prefix() -> String:
	return ""

func r315HonorRotation() -> bool:
	return true

func _onBodyEntered(body: Actor):
	touchingBodies.append(body)

func _onBodyExcited(body: Actor):
	var idx = touchingBodies.find(body)
	touchingBodies.remove(idx)
