extends "res://players/Char.gd"

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

func _on_physics_process(delta):
	parseInputs()
	calcDash()
	if not dashing and not predash:
		calculateJump()
		movement()
		imposeGravity()

func calcDash():
	if skill and dashAvailable and not dashing and not predash and not noDash:
		dashAvailable = false
		predash = true
		storedDirection = currentDirection
		
	if grounded and not dashing: #if you start a dash on the ground, 
		dashAvailable = true     #you'll have one in mid-air as well
	
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
