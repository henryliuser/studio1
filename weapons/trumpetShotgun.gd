extends "res://weapons/gun.gd"

func shoot():
	.shoot()
	var dir = player.currentDirection
	var launch = Vector2(dir*-2000, -300)
	for x in range(10):
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

	if player.down and !player.is_on_floor():
		launch = Vector2(dir*-1500, -900)
	elif player.down and player.is_on_floor():
		launch.y = 0
	player.velocity = launch
	player.sprite.rotation_degrees -= dir * 30
	rotation_degrees -= 15

