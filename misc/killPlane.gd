extends Area2D

func _on_killPlane_body_entered(body):
	if body.has_method("movement"): 
		body.die()
	elif body.get_parent().name == "Stage":
		pass
	elif body.name == "right_start" or body.name == "left_start":
		pass
	else: body.queue_free()
