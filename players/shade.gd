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

func _ready():
	dashInd = get_node("../Gauges/DashIndic")
	jumpInd = get_node("../Gauges/JumpIndic")

puppet func syncDash(d):
	dashInd.updateBar(d)
puppet func syncJump(d):
	jumpInd.updateBar(d)

func _on_physics_process(_delta):
	parseInputs()
	imposeGravity()
	if stunTimer.x == 0:
		calcDash()
		if not dashing and not predash:
			calculateJump()
			if jump and midairJumpsLeft == 0:
				jumpInd.updateBar(0)
#				rpc_unreliable("syncJump", 0)
			elif is_on_floor():
				jumpInd.updateBar(100)
#				rpc_unreliable("syncJump", 100)
			movement()

			

func calcDash():
	if skill and dashAvailable and not dashing and not predash and not noDash:
		dashAvailable = false
		predash = true
		storedDirection = currentDirection
		dashInd.updateBar(0)
#		rpc_unreliable("syncDash", 0)
		
	if grounded and not dashing: #if you start a dash on the ground, 
		dashAvailable = true     #you'll have one in mid-air as well
		if dashTimer == 0 && not predash:
			dashInd.updateBar(100)
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
		modulate = Color.paleturquoise
		velocity = Vector2(currentDirection*dashSpeed,0)
		dashTimer = dashTimer + 1
		if dashTimer == dashLock: #at the end of the dash, 
			currentDirection = storedDirection
			modulate = Color.white
			dashTimer = 0
			dashing = false
			noDash = true # this places dash on an x frame cooldown cuz spamming it is kinda fast
			
