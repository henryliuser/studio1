extends "res://weapons/gun.gd"

func shoot():
	.shoot()
	
	for x in range(8):
		var n = load("res://weapons/projectiles/note.tscn").instance()
		var velo = Vector2(player.currentDirection*(randi()%251+350), randi()%201-100)
		if Input.is_action_pressed(s+"down"):
			velo.x /= 1.5
			if player.is_on_floor(): velo.y = -(randi()%251 + 60)
			else: velo.y = randi()%251 + 60
		n.velocity = velo
		n.rot_speed_deg = randi()%601 - 300
		get_tree().current_scene.add_child(n)
#		get_tree().current_scene.move_child(n, 1)
		n.global_position = $Muzzle.global_position
	player.velocity = Vector2(player.currentDirection * -900, -500)
	player.sprite.rotation_degrees += player.currentDirection * 30
	rotation_degrees += 15
		
		
