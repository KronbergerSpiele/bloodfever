extends RigidBody2D

func _init():
	inertia = INF

func _ready():
	$AnimatedSprite.play('R000')

func _process(_delta: float):
	var vel = linear_velocity.length()
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
