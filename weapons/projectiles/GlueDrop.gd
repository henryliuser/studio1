extends Area2D
var velocity = Vector2(1,1)

func _on_GlueDrop_body_entered(body):
	if body.has_method("getHurt"):
		body.getHurt(15, 15, Vector2(200,-200), global_position)
		body.get_slowed(2, 3, true)

func _physics_process(delta):
	velocity.y += 50
	scale += Vector2(0.02, 0.02)
	global_position += velocity * delta
	$sprite.rotation = atan(velocity.y / velocity.x)
	
	if $groundCheck.is_colliding():
		var puddle = load("res://weapons/projectiles/gluePuddle.tscn").instance()
		puddle.position = $groundCheck.get_collision_point()
		scale += Vector2(0.5,0.5)
		get_tree().current_scene.add_child(puddle)
		queue_free()
