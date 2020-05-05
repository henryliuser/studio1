extends Node2D
onready var anim = $AnimationPlayer
export var pnum = 1

func _physics_process(delta):
	var playin = anim.is_playing()
	if Input.is_action_just_pressed("p" + str(pnum) + "_fire") and not anim.is_playing():
		anim.play("hit")
