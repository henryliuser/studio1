extends "res://weapons/gun.gd"

func shoot():
	available = false
	for x in range(0,3):
		var d1 = load("res://weapons/projectiles/poisonDart.tscn").instance()
		d1.global_position = $muzzle.global_position
		d1.global_rotation = global_rotation*player.currentDirection
		d1.velocity = Vector2(cos(global_rotation), sin(global_rotation)) * 1700
		d1.velocity.y *= player.currentDirection
		get_tree().current_scene.add_child(d1)
#		rotation_degrees += -player.currentDirection*5
		rotation_degrees -= 5
		position.x += -player.currentDirection*10
		yield(get_tree().create_timer(0.1), "timeout")
	.shoot()


