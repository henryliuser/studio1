extends Area2D
var bodies = {}

func _on_Cobweb_body_entered(body):
	if "maxAirVelocity" in body:
		bodies[body] = body.maxAirVelocity
		body.maxAirVelocity = Vector2(100, 100)

func _on_Cobweb_body_exited(body):
	if "maxAirVelocity" in body:
		body.maxAirVelocity = bodies[body]
		bodies.erase(body)
