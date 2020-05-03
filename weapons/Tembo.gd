extends Node2D
onready var anim = $AnimationPlayer
export var pnum = 1

onready var initX = position.x
onready var initRot = rotation_degrees


func _physics_process(delta):
	var playin = anim.is_playing()
	if Input.is_action_just_pressed("p" + str(pnum) + "_fire") and not anim.is_playing():
		anim.play("hit1")
	if position.x == -initX and not anim.is_playing():
		rotation_degrees = -initRot
	if position.x == initX and not anim.is_playing():
		rotation_degrees = initRot
	
