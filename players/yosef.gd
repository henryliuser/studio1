extends "res://players/tools/Char.gd"
onready var anim2 = get_node("../AnimationPlayer2")
onready var head_tween = $sprite/Tween
onready var head = $sprite/head

func _ready():
	head_tween.interpolate_property(head, "position:y", -1, 2, 0.6, 
		Tween.TRANS_SINE, 2)
	head_tween.interpolate_property(head, "position:y", 2, -1, 0.6,
		Tween.TRANS_SINE, 2, 0.6)
	head_tween.repeat = true
	head_tween.start()

func movement():
	var maxSpeeds
	var lerq = lerpWeight
	if not is_on_floor(): lerq = lerpWeight/3
	if grounded: maxSpeeds = maxGroundVelocity
	else: maxSpeeds = maxAirVelocity
#	if justRight: fixFlip(1) can't do this Trust me
#	if justLeft: fixFlip(-1)
	if right && not left:
		fixFlip(1)
		velocity.x += acceleration 
		velocity.x = min(velocity.x, maxSpeeds.x)
		if velocity.y == gravity: anim2.play("forward")
	elif left && not right:
		fixFlip(-1)
		velocity.x -= acceleration 
		velocity.x = max(velocity.x, -maxSpeeds.x)
		if velocity.y == gravity: anim2.play("forward")
	else:
		if velocity.y == 0: anim2.play("idle_feet")
		elif velocity.y < 0: anim2.play("jump")
		else: anim2.play("idle_feet")
		lerp0(lerq)
	velocity.y = min(velocity.y, maxSpeeds.y)

func calculateJump():
	if is_on_floor():
		grounded = true
		midairJumpsLeft = totalJumps-1
	else: 
		grounded = false
	if is_on_ceiling():
		velocity.y = 10
	
	if jump:
		if midairJumpsLeft > 0 && not grounded:
			midairJumpsLeft -= 1
			anim2.play("jump")
			velocity.y = -jumpSpeed 
		elif totalJumps > 0 && grounded:
			velocity.y = -jumpSpeed
			anim2.play("jump")
	
func die():
	.die()
	head_tween.stop_all()
	anim2.stop()
