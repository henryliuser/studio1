extends "res://weapons/gun.gd"

func shoot():
	.shoot()
	var drop = load("res://weapons/projectiles/GlueDrop.tscn").instance()
	drop.position = $Muzzle.global_position
	var dir = player.currentDirection if !("storedDirection" in player) else player.storedDirection
	drop.velocity = Vector2(dir * 700, -500)
	if player.is_on_floor() and Input.is_action_pressed(s+"down"): 
		drop.velocity = Vector2(dir*400, -700)
	elif Input.is_action_pressed(s+"down"):
		drop.velocity = Vector2(dir*500, 100)
	if dir == -1: drop.get_node('sprite').flip_h = true
	get_tree().current_scene.add_child(drop)
	player.velocity += Vector2(dir * -200, -200)
	player.sprite.rotation_degrees += -dir * 20
	rotation_degrees -= 15

