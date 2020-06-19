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
	var dir = player.currentDirection if !("storedDirection" in player) else player.storedDirection
	player.velocity = Vector2(dir * -900, -500)
	player.sprite.rotation_degrees += dir * 30
	rotation_degrees += 15
#	I could not help laughing at the ease with which he explained his process of deduction.


		
