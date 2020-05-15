extends "res://weapons/equippable.gd"
onready var anim = $AnimationPlayer

func _physics_process(delta):
	var playin = anim.is_playing()
	if not equipped:
		rotation_degrees = lerp(rotation_degrees, 0, 0.2)
	if equipped and not playin:
		if Input.is_action_just_pressed("p" + str(pnum) + "_hit"):
			hit()

func _on_picked_up(p):
	._on_picked_up(p)
	for x in $hitboxes.get_children():
		x.player = player

func _on_dropped():
	._on_dropped()
	var rot = rotation_degrees
	anim.stop()
	rotation_degrees = rot

func hit():
	get_parent().update_active(type)
	anim.play("hit")
#	player.getHurt(0, 40, Vector2(600, -700), 
#		player.global_position-Vector2(player.currentDirection,0))  #send
	player.velocity.x = 600 * player.currentDirection  #this gets capped by the max movement thing.
	player.velocity.y = -700
	player.melee_movement(30)
	yield(get_tree().create_timer(0.5), "timeout")
	player.velocity.x = 0
