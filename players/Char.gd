extends KinematicBody2D
#misc
export var gravity = 50
var currentDirection = 1
var storedDirection = 1
export var playerNum = 1
var tauntTimer = Vector2(0,10)

#animation variables
onready var sprite = $sprite
onready var hitbox = $hitbox
var hpbar
var label
var children = []

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
	hpbar = get_node("../HPBar")
	for c in get_children():
		children.append(c.position)
	

func _physics_process(delta):
	calcHitstun()
	if hp > 0:
		_on_physics_process(delta)
	velocity = move_and_slide(velocity, Vector2(0,-1))

func _on_physics_process(delta):
	imposeGravity()
	if stunTimer.x == 0:
		parseInputs()
		calculateJump()
		movement()


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
	if grounded: maxSpeeds = maxGroundVelocity
	else: maxSpeeds = maxAirVelocity
	
	if right && not left:
		currentDirection = 1
		velocity.x += acceleration 
		velocity.x = min(velocity.x, maxSpeeds.x)
		hitbox.scale.x = 1  # flip the hitbox when changing directions
		sprite.flip_h = false  # flip the sprite when changing directions
		sprite.play("forward")
	elif left && not right:
		currentDirection = -1
		velocity.x -= acceleration 
		velocity.x = max(velocity.x, -maxSpeeds.x)
		hitbox.scale.x = -1
		sprite.flip_h = true
		sprite.play("forward")
	else:
		velocity.x = lerp(velocity.x, 0, lerpWeight)
		sprite.play("idle")
	velocity.y = min(velocity.y, maxSpeeds.y)
	
	var a = 0
	for c in get_children():
		c.position.x = children[a].x * currentDirection
		a += 1
	
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
	var t = position.x-pos.x  #knocks back horizontally based on x position 
	var q = position.y-pos.y
	velocity = Vector2(t/abs(t)*kb.x, q/abs(q)*kb.y) 
	hp -= dmg
	hpbar.updateBar(hp)
	if hp <= 0:
		die()
	
func die():
	$hitbox.queue_free()
	velocity = Vector2()
	sprite.play("death")
