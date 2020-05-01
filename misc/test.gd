extends KinematicBody2D

onready var scaleInit = scale 
var currentDirection = 1

func fixFlip(dir):
	currentDirection = dir
	scale.x = scaleInit.x * currentDirection
	print(scale)
	
func _physics_process(delta):
	if Input.is_action_just_pressed("p1_left"):
		fixFlip(-1)
	if Input.is_action_just_pressed("p1_right"):
		fixFlip(1)
