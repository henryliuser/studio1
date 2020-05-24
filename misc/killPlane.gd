extends Area2D

func _on_killPlane_body_entered(body):
	if body.has_method("movement"): body.get_parent().queue_free()
	else: body.queue_free()
