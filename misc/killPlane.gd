extends Area2D

func _on_killPlane_body_entered(body):
	if body.has_method("movement"): 
		body.die()
	elif body.get_parent().name == "Stage":
		pass
	else: body.queue_free()
