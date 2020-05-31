extends "res://players/tools/Char.gd"

#dash variables
export var dashLock = 12
export var dashSpeed = 1300
export var dashCD = 3
const predashDuration = 4
var storedDirection = 1
var noDash = false
var dashAvailable = true
var dashing = false
var predash = false
var dashTimer = 0
var dashInd
var jumpInd
onready var trails = get_node("../Trails")

var oneMidAirDashReset = true

func _ready():
#	acceleration = 120
	dashInd = get_node("../Gauges/DashIndic")
	jumpInd = get_node("../Gauges/JumpIndic")
	trails.modulate = Color.paleturquoise

puppet func syncDash(d):
	dashInd.updateBar(d)
puppet func syncJump(d):
	jumpInd.updateBar(d)

func _on_physics_process(_delta):
	if stunTimer.x == 0:
		calcDash()
		if not dashing and not predash:
			movement()
			calcWalls()
			calculateJump()
			if jump and midairJumpsLeft == 0:
				jumpInd.updateBar(0)
#				rpc_unreliable("syncJump", 0)
			elif is_on_floor():
				jumpInd.updateBar(100)
#				rpc_unreliable("syncJump", 100)
		calcTrails()
func imposeGravity():
	if not (L or R):
		.imposeGravity()

func fixFlip(dir):
	currentDirection = dir
	if not dashing: storedDirection = dir
	hurtbox.scale.x = currentDirection
	for c in get_children():
		if c.name == "rightWall" or c.name == "leftWall":
			continue
		c.position.x = children[c].x * currentDirection
		c.scale.x = abs(c.scale.x) * currentDirection

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
		if trail_overtime <= 7: velocity.x += acceleration 
#		if (trail_overtime >= 0 and trail_overtime <= 13 and velocity.x > 0):
#			velocity.x = lerp(velocity.x, maxSpeeds.x, 0.5)
#		else: 
		if trail_overtime <= 8: velocity.x = min(velocity.x, maxSpeeds.x)
		sprite.play("forward")
	elif left && not right:
		fixFlip(-1)
		if trail_overtime <= 7: velocity.x -= acceleration 
		if trail_overtime <= 8:velocity.x = max(velocity.x, -maxSpeeds.x)
#		if (trail_overtime >= 0 and trail_overtime <= 13 and velocity.x < 0):
#			velocity.x = lerp(velocity.x, -maxSpeeds.x, 0.5)
#		else: velocity.x = max(velocity.x, -maxSpeeds.x)
		sprite.play("forward")
	else:
		sprite.play("idle")
		lerp0(lerq)
	velocity.y = min(velocity.y, maxSpeeds.y)

var L; var R
func calcWalls():
	var leftRelease = true if Input.is_action_just_released("p" + str(localNum) + "_left") else false
	var rightRelease = true if Input.is_action_just_released("p" + str(localNum) + "_right") else false
	var LColl = $leftWall.get_collider()
	var RColl = $rightWall.get_collider()
	var coll
	L = left and $leftWall.is_colliding() and LColl.is_wall 
	leftRelease = leftRelease and $leftWall.is_colliding() and LColl.is_wall
	R = right and $rightWall.is_colliding() and RColl.is_wall
	rightRelease = rightRelease and $rightWall.is_colliding() and RColl.is_wall
	if L: 
		fixFlip(1)
		coll = LColl
	elif R: 
		fixFlip(-1)
		coll = RColl
	if L or R:
		velocity.y = lerp(velocity.y, coll.velocity.y + 20, 0.5)
	if rightRelease: velocity.x = -250
	if leftRelease: velocity.x = 250
	if (L or R) and down:
		velocity.y = 300
	
		
func calculateJump():
	if is_on_floor():
		grounded = true
		midairJumpsLeft = totalJumps-1
	else: 
		grounded = false
	if is_on_ceiling():
		velocity.y = 10
	if (L or R) and jump:  # walljump
		velocity.y += -jumpSpeed / 1.4
		velocity.x = currentDirection * 800
	elif jump:
		if midairJumpsLeft > 0 && not grounded:
			midairJumpsLeft -= 1
			velocity.y = -jumpSpeed
		elif totalJumps > 0 && grounded:
			velocity.y = -jumpSpeed

func calcDash():
	if skill and dashAvailable and not dashing and not predash and not noDash:
		dash_origin = global_position
		dashAvailable = false
		predash = true
		storedDirection = currentDirection
		dashInd.updateBar(0)
#		rpc_unreliable("syncDash", 0)
		
	if grounded and not dashing: #if you start a dash on the ground, 
		dashAvailable = true     #you'll have one in mid-air as well
		oneMidAirDashReset = true
		if dashTimer == 0 && not predash and hp > 0:
			grant_dash()
#			rpc_unreliable("syncDash", 100)
	if predash:
		if left and not right:
			currentDirection = -1
		if right and not left:
			currentDirection = 1
		dashTimer = dashTimer + 1
		if dashTimer == predashDuration:
			predash = false
			dashing = true
	
	if noDash:
		dashTimer = dashTimer + 1
		if dashTimer == dashLock + dashCD:
			noDash = false
			dashTimer = 0
			if dashAvailable:
				dashInd.updateBar(100)
#				rpc_unreliable("syncDash", 100)
	
	if dashing:
		sprite.rotation_degrees = 15 if currentDirection == 1 else -25
		sprite.modulate.a = 0.7
		dashTimer += 1
		modulate = Color.paleturquoise
		velocity = Vector2(currentDirection*dashSpeed,0)
		if dashTimer == dashLock: #at the end of the dash, 
			currentDirection = storedDirection
			dashTimer = 0
			dashing = false
			noDash = true # this places dash on an x frame cooldown cuz spamming it is kinda fast
			
func getHurt(dmg, stun:int=10, kb:Vector2=Vector2(), pos:Vector2=Vector2() ):
	.getHurt(dmg,stun,kb,pos)
	if kb != Vector2():
		dashTimer = 0
		dashing = false
		predash = false
		if oneMidAirDashReset and hp > 0 and !is_on_floor(): 
			grant_dash()
			oneMidAirDashReset = false
	
func grant_dash():
	noDash = false
	dashAvailable = true
	dashInd.updateBar(100)
	
func restore():
	hurtbox.scale.y = lerp(hurtbox.scale.y, 1, 0.2)
	rotation_degrees = lerp(rotation_degrees, 0, 0.2)
	if trail_overtime <= 0: modulate = modulate.linear_interpolate(Color.white,0.1)
	sprite.modulate.a = lerp(sprite.modulate.a, 1, 0.2)
	if unactionable.x == 0 and trail_overtime <= 0: 
		sprite.rotation_degrees = lerp(sprite.rotation_degrees, 0, 0.2)

var dash_origin 
var trail_overtime = 15
func calcTrails():
	var trail_lerp = 0.91
	for t in trails.get_children():
		
		if dashing:
			trail_overtime = 18
			t.global_position = dash_origin
			t.visible = true
		else:
			if t.visible: trail_overtime -= 1
			if trail_overtime <= 0: 
				t.visible = false
#				modulate = Color.white
		t.modulate.a = lerp(0, sprite.modulate.a-0.3, trail_lerp)
		if trail_lerp == 0.5: t.modulate.a = 0.15
#		t.modulate.a = max(sprite.modulate.a*trail_lerp+0.1, sprite.modulate.a-0.1)
#		t.global_rotation = lerp(0,sprite.rotation,trail_lerp)
		t.global_rotation = sprite.rotation
		t.global_position.x = lerp(t.global_position.x, sprite.global_position.x, trail_lerp)
		t.global_position.y = global_position.y
		t.scale = Vector2(storedDirection*3,3)
		trail_lerp -= 0.25
		if trail_lerp < 0.5: trail_lerp = 0.5
#		t.modulate.a = 0

#   ================================================================== THEORY VVVV

#	var trail_lerp = 0.91
#	var t1 = trails.get_node("trail1")
#	var t2 = trails.get_node("trail2")
#	var t3 = trails.get_node("trail3")
#	if dashing:
#		trail_overtime = 15
#		t1.global_position = dash_origin
#		t1.visible = true; t2.visible = true; t3.visible = true
#	else:
#		if t1.visible: trail_overtime -= 1
#		else: 
#			t1.visible = false; t2.visible = false; t3.visible = false
#			modulate = Color.white
#	t1.global_position.x = lerp(t1.global_position.x, sprite.global_position.x, trail_lerp)
#	var length = global_position.x - t1.global_position.x
#	t2.global_position.x = t1.global_position.x + length/3
#	t3.global_position.x = t1.global_position.x + 2*length/3
#	for t in trails.get_children():
#		t.modulate.a = lerp(0, sprite.modulate.a-0.3, trail_lerp)
#		t.global_rotation = sprite.rotation
#		t.global_position.y = global_position.y
#		t.scale = Vector2(storedDirection*3,3)
#		trail_lerp -= 0.27
##		if trail_lerp < 0.5: trail_lerp = 0.5

func die():
	trails.queue_free()
	.die()
		
		
		
		
		
