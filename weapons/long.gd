extends Node2D

func _physics_process(delta):
	if Input.is_action_just_pressed("p1_fire"):
		var q = load("res://projectiles/boomerang.tscn").instance()
		q.position = position + Vector2(100,0)
		get_tree().get_root().add_child(q)
