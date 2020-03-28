extends "res://players/Char.gd"

var acc
var jetSpeed = 65
var fuel = 150
var maxFuel = 150
onready var jetflame = $jetflame
onready var flamePos = jetflame.position

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
		hitbox.scale.x = 1  # flip the sprite when changing directions
		sprite.flip_h = false
		sprite.play("forward")
	elif left && not right:
		currentDirection = -1
		velocity.x -= acc 
		velocity.x = max(velocity.x, -maxSpeeds.x)
		hitbox.scale.x = -1
		sprite.flip_h = true
		sprite.play("forward")
	elif is_on_floor():
		velocity.x = lerp(velocity.x, 0, lerpWeight)
		sprite.play("idle")
		
#	if justRight and not justRight:
#		jetflame.position.x = flamePos.x
#	elif justLeft and not justLeft:
#		jetflame.position.x = -flamePos.x 
#	else:
#		jetflame.position.x = flamePos.x * currentDirection

	var a = 0
	for c in get_children():
		c.position.x = children[a].x * currentDirection
		a += 1
	
	if velocity.y >= 0:
		velocity.y = min(velocity.y, maxSpeeds.y)
	else:
		velocity.y = max(velocity.y, -(maxSpeeds.y/2))
	
	#check if |sub-1| movement speed then just stop
	if abs(velocity.x) <= 1:
		velocity.x = 0
	if abs(velocity.y) <= 1:
		velocity.y = 0
		
func jet():
	jetflame.visible = true
	velocity.y -= jetSpeed
	fuel -= 2
	fuel = max(0,fuel)

func calcJet():
	jetflame.visible = false
	if is_on_floor():
		fuel += 3
		fuel = min(fuel, maxFuel)
		if fuel >= 30 and holdSkill:
			jet()
		
	elif holdSkill and fuel > 0:
		jet()

func die():
	.die()
	jetflame.visible = false

func _on_jetpack_body_entered(body):
	fuel = max(0, fuel-50)
