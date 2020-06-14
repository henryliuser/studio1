extends "res://weapons/gun.gd"

func shoot():
	for x in range(6):
		var n = load("res://weapons/projectiles/note.tscn").instance()
		n.velocity = Vector2(player.currentDirection*(randi()%201+100), randi()%71-35)
		get_tree().current_scene.add_child(n)
		get_tree().current_scene.move_child(n, 1)
		n.global_position = $Muzzle.global_position
		
		
