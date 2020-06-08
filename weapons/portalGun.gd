extends "res://weapons/gun.gd"

func shoot():
	var p = load("res://weapons/projectiles/portal.tscn").instance()
	p.player = player
	p.apply_impulse(Vector2(), Vector2(player.currentDirection * 100, -100))
	get_tree().current_scene.add_child(p)
