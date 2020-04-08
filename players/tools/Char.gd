extends KinematicBody2D
#misc
export var gravity = 50
var currentDirection = 1
var storedDirection = 1
export var playerNum = 1
var tauntTimer = Vector2(0,10)

#animation variables
onready var sprite = $sprite
onready var hurtbox = $hurtbox
var hpbar
var label
var children = []

#attackVars
var shortPath = ""
var longPath = ""

#input variables
var left
var right
var fire
var down
var skill
var jump
var hit
var taunt

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

func _ready(): 
	hpbar = get_node("../Gauges/HPBar")
#	set_network_master(get_tree().get_network_unique_id())
	for c in get_children():
		children.append(c.position)
	
puppet func setEverything(vel, pos, sprFlip, scl, mod, currDirec):
	position = pos; velocity = vel; scale = scl; modulate = mod; 
	sprite.flip_h = sprFlip; currentDirection = currDirec

func _physics_process(delta):
	if is_network_master():
		calcHitstun()
		if hp > 0:
			_on_physics_process(delta)
		rpc_unreliable("setEverything", velocity,position,sprite.flip_h,scale,modulate,currentDirection)
	fixFlip()
	velocity = move_and_slide(velocity, Vector2(0,-1))
	
func fixFlip():
	var a = 0
	for c in get_children():
		c.position.x = children[a].x * currentDirection
		hurtbox.scale.x = currentDirection
		a += 1

func _on_physics_process(delta):
	imposeGravity()
	if stunTimer.x == 0:
		parseInputs()
		calculateJump()
		movement()
		calcHit()

func imposeGravity():
	velocity.y += gravity

func parseInputs():
	var n = "p" + str(playerNum) + "_"
	left = Input.is_action_pressed(n+"left");
	right = Input.is_action_pressed(n+"right");
	fire = Input.is_action_just_pressed(n+"fire")
	hit = Input.is_action_just_pressed(n+"hit")
	down = Input.is_action_just_pressed(n+"down")
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

	if right && not left:
		currentDirection = 1
		velocity.x += acceleration 
		velocity.x = min(velocity.x, maxSpeeds.x)
		hurtbox.scale.x = 1  # flip the hurtbox when changing directions
		sprite.flip_h = false  # flip the sprite when changing directions
		sprite.play("forward")
	elif left && not right:
		currentDirection = -1
		velocity.x -= acceleration 
		velocity.x = max(velocity.x, -maxSpeeds.x)
		hurtbox.scale.x = -1
		sprite.flip_h = true
		sprite.play("forward")
	else:
		sprite.play("idle")
		velocity.x = lerp(velocity.x, 0, lerq)
	velocity.y = min(velocity.y, maxSpeeds.y)
	
	#check if |sub-1| movement speed then just stop
	if abs(velocity.x) <= 1:
		velocity.x = 0
	if abs(velocity.y) <= 1:
		velocity.y = 0

func calcTaunt():
	if taunt:
		pass

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

func getHurt(dmg, stun:int=10, kb:Vector2=Vector2(), pos:Vector2=Vector2() ):
	stunTimer.x = 1
	stunTimer.y = stun
	modTimer.x = 1
	modulate = Color.red
	var t = global_position.x-pos.x  #knocks back horizontally based on x position 
	velocity = Vector2(t/abs(t)*kb.x, kb.y) 
	hp -= dmg
	hpbar.updateBar(hp)
	if hp <= 0:
		die()
	
func die():
	$hurtbox.queue_free()
	velocity = Vector2()
	sprite.play("death")
	
func calcHit():
	if hit:
		hit(shortPath)
	if fire:
		hit(longPath)

func hit(path):
	var x = load(path).instance()
	x.pos = global_position
	x.position = position + Vector2(currentDirection*80, -40)
	x.scale.x = currentDirection
	get_parent().add_child(x)

