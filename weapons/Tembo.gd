extends "res://weapons/equippable.gd"
onready var anim = $AnimationPlayer

func _physics_process(delta):
	var playin = anim.is_playing()
	if not equipped:
		rotation_degrees = lerp(rotation_degrees, 0, 0.2)
	if equipped and not playin:
		if Input.is_action_just_pressed("p" + str(pnum) + "_hit"):
			hit()
			
	if playin and player.is_on_floor(): player.melee_velo = Vector2()
	if playin: hoverTween.stop_all()
	else: hoverTween.resume_all()

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
	$sprite.position = spriteInitPos
#	player.getHurt(0, 40, Vector2(600, -700), 
#		player.global_position-Vector2(player.currentDirection,0))  #send
	if Input.is_action_pressed(s+"down"):
		player.velocity.y = -1200
		player.velocity.x = 200 * player.currentDirection
		player.melee_movement(55, true, false, Vector2(0,20))
#		player.melee_movement(60, true, false, Vector2(70*player.currentDirection, 0))  #parabola too slow lookin
		yield(get_tree().create_timer(0.03),"timeout")
#		player.melee_velo = Vector2()  # play around with idea that u do fast launch and then stop?
		player.velocity.x = 750 * player.currentDirection
		
	else:
		player.velocity.x = 2200 * player.currentDirection  
		player.velocity.y = -750
		player.melee_movement(50, true, false)
		
