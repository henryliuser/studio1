extends "res://weapons/projectiles/projectile.gd"
export var lerpWeight = 0.94

var target = Vector2(1000,0)
var ogPos

var time = 0
var speed = 50.0
const guesSpeed = 1.049
var reached = false

func _ready():
	target += global_position

func _physics_process(delta):
	speed /= guesSpeed
	time += 1
	rotation_degrees += 500*delta
	var gap = target - global_position
#	if abs(gap.x) < 1: 
#		reached = true
#	if reached:
#		speed *= guesSpeed*guesSpeed
#		gap = ogPos - global_position
#		if global_position-ogPos <= Vector2(): queue_free()
#	global_position += unit(gap)*speed
	
	if abs(gap.x) < 5: 
		reached = true
		time = 0
	if reached:
		gap = ogPos - global_position
		global_position += unit(gap)*pow(2-lerpWeight+0.03, time)
		if global_position-ogPos <= Vector2(): queue_free()
	else:
		global_position = target - gap*pow(lerpWeight, time)
	
func unit(v2):
	return v2 / sqrt(v2.x*v2.x + v2.y*v2.y)
