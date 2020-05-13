extends KinematicBody2D
#misc
export var gravity = 50
var currentDirection = 1
var storedDirection = 1

var netID = 0
export var localNum = 1
var tauntTimer = Vector2(0,10)

signal hurt(player, dmg)
signal die

#animation variables
onready var sprite = $sprite
onready var hurtbox = $hurtbox
var hpbar
var label
var children = []

#input variables
var left; var right; var down; var jump
var fire; var skill; var hit; var taunt

var holdSkill
var justLeft
var justRight

#health
var hp = 100
var modTimer = Vector2(0,5)
var stunTimer = Vector2(0,10)

#movement variables
export var maxAirVelocity = Vector2(450,1500)
export var maxGroundVelocity = Vector2(400,1500)
export var acceleration = 80
export var lerpWeight = 0.3
var velocity = Vector2()

#jump variables
export var jumpSpeed = 1000
export var totalJumps = 1
var grounded = true
var midairJumpsLeft = totalJumps - 1

#siblings
onready var Gauges = get_node("../Gauges")
onready var Weapons = get_node("../Weapons")

func _ready(): 
	set_network_master(0)
	for c in get_children():
		children.append(c.position)
	hpbar = get_node("../Gauges/HPBar")
	
puppet func setEverything(vel, pos, sprFlip, scl, mod, currDirec):
	position = pos; velocity = vel; scale = scl; modulate = mod; 
	sprite.flip_h = sprFlip; currentDirection = currDirec

func _physics_process(delta):
#	if is_network_master():
	rotation_degrees = lerp(rotation_degrees, 0, 0.2)
	calcHitstun()
	imposeGravity()
	if hp > 0 and stunTimer.x == 0: _on_physics_process(delta)
	if hp <= 0 and stunTimer.x == 0: lerp0(lerpWeight/3)
#	rpc_unreliable("setEverything", velocity,position,sprite.flip_h,scale,modulate,currentDirection)
	velocity = move_and_slide(velocity, Vector2(0,-1))
	
func fixFlip(dir):
	currentDirection = dir
	var a = 0
	for c in get_children():
		c.position.x = children[a].x * currentDirection
		c.scale.x = abs(c.scale.x) * currentDirection
		a += 1


func _on_physics_process(_delta):
	parseInputs()
	calculateJump()
	movement()

func imposeGravity():
	velocity.y += gravity

func parseInputs():
	var n = "p" + str(localNum) + "_"
	left = Input.is_action_pressed(n+"left");
	right = Input.is_action_pressed(n+"right");
	fire = Input.is_action_just_pressed(n+"fire")
	hit = Input.is_action_just_pressed(n+"hit")
	down = Input.is_action_pressed(n+"down")
	skill = Input.is_action_just_pressed(n+"skill")
	holdSkill = Input.is_action_pressed(n+"skill")
	jump = Input.is_action_just_pressed(n+"jump")
	taunt = Input.is_action_just_pressed(n+"taunt")
	
	justLeft = Input.is_action_just_pressed(n+"left")
	justRight = Input.is_action_just_pressed(n+"right")
	
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
		sprite.play("forward")
	elif left && not right:
		fixFlip(-1)
		velocity.x -= acceleration 
		velocity.x = max(velocity.x, -maxSpeeds.x)
		sprite.play("forward")
	else:
		sprite.play("idle")
		lerp0(lerq)
	velocity.y = min(velocity.y, maxSpeeds.y)
		
func lerp0(l):
	velocity.x = lerp(velocity.x, 0, l)
	#check if |sub-1| movement speed then just stop
	if abs(velocity.x) <= 1:
		velocity.x = 0
	if abs(velocity.y) <= 1:
		velocity.y = 0

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
			velocity.y = -jumpSpeed 
		elif totalJumps > 0 && grounded:
			velocity.y = -jumpSpeed

func calcHitstun():
	if modTimer.x > 0:
		modTimer.x += 1
		if modTimer.x >= modTimer.y:
			modTimer.x = 0
			modulate = Color.white
	#calc stun
	if stunTimer.x > 0:
		stunTimer.x += 1
		if stunTimer.x >= stunTimer.y:
			stunTimer.x = 0

# take 'dmg' damage, get stunned for 'stun' frames, get knocked back by
# absolute Vector2(kb), in the direction based on Vector2(pos)
func getHurt(dmg, stun:int=10, kb:Vector2=Vector2(), pos:Vector2=Vector2() ):
	
	stunTimer.x = 1
	stunTimer.y = stun  # set up the hitstun
	if dmg > 0:
		emit_signal("hurt", self, dmg)
		modTimer.x = 1  
		modulate = Color.red  # set up red modulation flash
	var t = global_position.x-pos.x  #knocks back horizontally based on x pos
	if kb != Vector2():
		if t < 0: fixFlip(1)
		else: fixFlip(-1)
	velocity = Vector2(t/abs(t)*kb.x, kb.y) 
	position += velocity/30
	hp -= dmg
	hpbar.updateBar(hp)
	if hp <= 0:
		die()
	
func die():
	sprite.play("death")
#	for x in get_node("../Gauges").get_children():
#		x.die()
	set_collision_mask(18)
	set_collision_layer(0)
	emit_signal("die")
	yield(get_tree().create_timer(2),"timeout")
	get_parent().queue_free()
	
func _on_shoot():
	pass
