extends "res://players/Char.gd"

var acc
var jetSpeed = 65

func _ready(): 
	totalJumps = 0
	acceleration = 80

func _on_physics_process(delta):
	._on_physics_process(delta)
	calcJet()

func movement():
	var maxSpeeds
	if grounded: maxSpeeds = maxGroundVelocity
	else: maxSpeeds = maxAirVelocity
	
	if not is_on_floor():
		acc = acceleration/4
	else:
		acc = acceleration
	
	if right && not left:
		currentDirection = 1
		velocity.x += acc 
		velocity.x = min(velocity.x, maxSpeeds.x)
		sprite.flip_h = false  # flip the sprite when changing directions
		sprite.play("forward")
	elif left && not right:
		currentDirection = -1
		velocity.x -= acc 
		velocity.x = max(velocity.x, -maxSpeeds.x)
		sprite.flip_h = true
		sprite.play("forward")
	elif is_on_floor():
		velocity.x = lerp(velocity.x, 0, lerpWeight)
		sprite.play("idle")
	
	if velocity.y >= 0:
		velocity.y = min(velocity.y, maxSpeeds.y)
	else:
		velocity.y = max(velocity.y, -(maxSpeeds.y/2))
	
	#check if |sub-1| movement speed then just stop
	if abs(velocity.x) <= 1:
		velocity.x = 0
	if abs(velocity.y) <= 1:
		velocity.y = 0
		
func calcJet():
	if holdSkill:
		velocity.y -= jetSpeed
		
