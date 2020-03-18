extends Area2D
var b

func _physics_process(delta):
	pass

func _on_Area2D_body_entered(body):
	b = body
	body.velocity.x = 1

func _on_Area2D_body_exited(body):
	pass
