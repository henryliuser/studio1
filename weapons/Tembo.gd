extends "res://weapons/equippable.gd"
onready var anim = $AnimationPlayer

func _physics_process(delta):
	var playin = anim.is_playing()
	if equipped and not playin:
		if Input.is_action_just_pressed("p" + str(pnum) + "_hit"):
			anim.play("hit")
			
func _on_picked_up():
	for x in $hitboxes.get_children():
		x.player = player
	
