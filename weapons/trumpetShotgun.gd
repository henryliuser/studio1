extends "res://weapons/gun.gd"

func shoot():
	.shoot()
	for x in range(8):
		var n = load("res://weapons/projectiles/note.tscn").instance()
		n.velocity = Vector2(player.currentDirection*(randi()%251+450), randi()%201-75)
		n.rot_speed_deg = randi()%601 - 300
		get_tree().current_scene.add_child(n)
#		get_tree().current_scene.move_child(n, 1)
		n.global_position = $Muzzle.global_position
	player.velocity = Vector2(player.currentDirection * -900, -500)
	player.sprite.rotation_degrees += player.currentDirection * 30
	rotation_degrees += 15
		
		
