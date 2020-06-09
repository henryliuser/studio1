extends "res://weapons/gun.gd"

func shoot():
	.shoot()
	var p = load("res://weapons/projectiles/portal.tscn").instance()
	p.player = player
	p.rot_speed_deg *= player.currentDirection
	if player.is_on_floor() and Input.is_action_pressed(s+"down"):
		p.velocity.x /= 2; p.velocity.y -= 200
	elif !player.is_on_floor() and Input.is_action_pressed(s+"down"):
		p.velocity.x /= 2; p.velocity.y *= -1; p.velocity.y /= 3
	p.velocity.x *= player.currentDirection
	p.global_position = $Muzzle.global_position
	get_tree().current_scene.add_child(p)
	player.rotation_degrees -= player.currentDirection*25
	player.global_position.x -= player.currentDirection*20
	rotation_degrees -= 30
	
	
