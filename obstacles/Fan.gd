extends Area2D
export var acceleration = 30
var bodies = {}

func _physics_process(delta):
	for b in bodies:
		if bodies[b]: b.velocity.x -= acceleration

func _on_Fan_body_entered(body):
	if "velocity" in body:
		bodies[body] = true
		

func _on_Fan_body_exited(body):
	if "velocity" in body:
		bodies.erase(body)
