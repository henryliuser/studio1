extends "res://weapons/gun.gd"

func shoot():
	for x in range(0,3):
		var d1 = load("res://weapons/projectiles/poisonDart.tscn").instance()
		d1.global_position = $muzzle.global_position
		d1.global_rotation = global_rotation
		d1.velocity = Vector2(cos(global_rotation), sin(global_rotation)) * 600
		add_child(d1)
		rotation_degrees += 5
		yield(get_tree().create_timer(0.1), "timeout")
	.shoot()


