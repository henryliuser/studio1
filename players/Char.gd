extends KinematicBody2D
#misc
export var gravity = 50
var currentDirection = 1
var storedDirection = 1
export var playerNum = 1

#animation variables
onready var sprite = $sprite

#input variables
var left
var right
var fire
var down
var skill
var holdSkill
var jump
var hit
var taunt

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
	if playerNum == 2:  # turn them around if they're player 2
		currentDirection = 1
		storedDirection = 1
		sprite.flip_h = true
		sprite.modulate = Color.peru

func _physics_process(delta):
	_on_physics_process(delta)

func _on_physics_process(delta):
	parseInputs()
	calculateJump()
	movement()
	imposeGravity()
	velocity = move_and_slide(velocity,Vector2(0,-1))

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
	
func movement():
	var maxSpeeds
	if grounded: maxSpeeds = maxGroundVelocity
	else: maxSpeeds = maxAirVelocity
	
	if right && not left:
		currentDirection = 1
		velocity.x += acceleration 
		velocity.x = min(velocity.x, maxSpeeds.x)
		sprite.flip_h = false #flip the sprite when changing directions
		sprite.play("forward")
	elif left && not right:
		currentDirection = -1
		velocity.x -= acceleration 
		velocity.x = max(velocity.x, -maxSpeeds.x)
		sprite.flip_h = true
		sprite.play("forward")
	else:
		velocity.x = lerp(velocity.x, 0, lerpWeight)
		sprite.play("idle")
	velocity.y = min(velocity.y, maxSpeeds.y)
	
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
		elif grounded:
			velocity.y = -jumpSpeed
