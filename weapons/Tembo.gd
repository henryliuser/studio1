extends "res://weapons/melee.gd"
onready var player_tween = $PlayerTween
func _physics_process(delta):
	if anim.is_playing() and player.is_on_floor(): player.melee_velo = Vector2()
	._physics_process(delta)
	

func hit():
	.hit()
#	player.getHurt(0, 40, Vector2(600, -700), 
#		player.global_position-Vector2(player.currentDirection,0))  #send
	player_tween.interpolate_property(player.sprite,"rotation_degrees",
		player.rotation_degrees, -player.currentDirection*30, 0.4, 
		Tween.TRANS_CUBIC,Tween.EASE_OUT)
	player_tween.interpolate_property(player.sprite,"rotation_degrees",
		-player.currentDirection*30, player.currentDirection*10, 0.1, 
		Tween.TRANS_CUBIC,Tween.EASE_OUT, 0.4)
	player_tween.start()

	if Input.is_action_pressed(s+"down"):
		player.velocity.y = -1300
		player.velocity.x = 200 * player.currentDirection
		player.melee_movement(55, true, false, Vector2(0,30))
		
#		player.melee_movement(60, true, false, Vector2(70*player.currentDirection, 0))  #parabola too slow lookin
		yield(get_tree().create_timer(0.03),"timeout")
#		player.melee_velo = Vector2()  # play around with idea that u do fast launch and then stop?
		player.velocity.x = 750 * player.currentDirection
#		yield(get_tree().create_timer(0.25),"timeout")
#		player.modulate = Color.green
#		player.velocity.y += 50
		
	elif player.left or player.right:  # i guess if face right, press left on same frame as hit u 
		player.velocity.y = -750       # might be able to go right depending on order
		player.velocity.x = 2200 * player.currentDirection
		player.melee_movement(50, true, false)
	else:
		player.melee_movement(50, true, false)
		yield(get_tree().create_timer(0.5), "timeout") 
		player.velocity.y = -600
		player.velocity.x = -600 * player.currentDirection
		
