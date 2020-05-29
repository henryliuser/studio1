extends "res://players/tools/Char.gd"

#dash variables
export var dashLock = 12
export var dashSpeed = 1300
export var dashCD = 3
const predashDuration = 4
var noDash = false
var dashAvailable = true
var dashing = false
var predash = false
var dashTimer = 0
var dashInd
var jumpInd

var oneMidAirDashReset = true

func _ready():
	dashInd = get_node("../Gauges/DashIndic")
	jumpInd = get_node("../Gauges/JumpIndic")

puppet func syncDash(d):
	dashInd.updateBar(d)
puppet func syncJump(d):
	jumpInd.updateBar(d)

func _process(delta):
	pass
	

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
	var a = 0
	hurtbox.scale.x = currentDirection
	for c in get_children():
		if c.name == "rightWall" or c.name == "leftWall":
			continue
		c.position.x = children[c].x * currentDirection
		c.scale.x = abs(c.scale.x) * currentDirection

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
		sprite.rotation_degrees = currentDirection * 20
#		scale.y = og_scale.y + 0.2
#		scale.x = og_scale.x - 0.2
		sprite.modulate.a = 0.3
		dashTimer += 1
		modulate = Color.paleturquoise
		velocity = Vector2(currentDirection*dashSpeed,0)
		if dashTimer == dashLock: #at the end of the dash, 
			currentDirection = storedDirection
			modulate = Color.white
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
	rotation_degrees = lerp(rotation_degrees, 0, 0.2)
	sprite.modulate.a = lerp(sprite.modulate.a, 1, 0.2)
	if unactionable.x == 0 and !dashing: sprite.rotation_degrees = lerp(sprite.rotation_degrees, 0, 0.2)

var dash_origin 
var first_frame_of_dash
func calcTrails():
	var trails = get_node("../Trails")
	var trail_lerp = 1
	for t in trails.get_children():
		if dashing:
			t.global_position = dash_origin
			t.visible = true
		else: t.visible = false
		t.modulate.a = sprite.modulate.a-0.1
		t.global_position.x = lerp(t.global_position.x, sprite.global_position.x, trail_lerp)
		t.global_position.y = global_position.y
		t.scale = Vector2(storedDirection*3,3)
		trail_lerp -= 0.33
		
		
		
