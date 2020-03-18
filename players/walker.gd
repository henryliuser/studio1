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
#var jump
var hit

#movement variables
var acc = 40
export var maxAirVelocity = Vector2(350,1500)
export var maxGroundVelocity = Vector2(500,1500)
export var acceleration = 40
export var lerpWeight = 0.1
var grounded = true
var velocity = Vector2()

func _ready(): 
	if playerNum == 2:  # turn them around if they're player 2
		currentDirection = 1
		storedDirection = 1
		sprite.flip_h = true
		sprite.modulate = Color.peru

func _physics_process(delta):
	parseInputs()
	calcJet()
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
	skill = Input.is_action_pressed(n+"skill")  # hold down
#	jump = Input.is_action_just_pressed(n+"jump")  # dude got no hops

func movement():
	var maxSpeeds
	if grounded: maxSpeeds = maxGroundVelocity
	else: maxSpeeds = maxAirVelocity
	
	if not is_on_floor():
		acceleration = acc/4
	else:
		acceleration = acc
		
	if right && not left:
		currentDirection = 1
		velocity.x += acceleration 
		velocity.x = min(velocity.x, maxSpeeds.x)
		sprite.flip_h = false #flip the sprite when changing directions
	elif left && not right:
		currentDirection = -1
		velocity.x -= acceleration 
		velocity.x = max(velocity.x, -maxSpeeds.x)
		sprite.flip_h = true
	elif is_on_floor():
		velocity.x = lerp(velocity.x, 0, lerpWeight)
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
	if skill:
		velocity.y -= 65
