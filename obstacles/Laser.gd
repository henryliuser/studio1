extends Node2D
onready var line = $Line2D
onready var hitbox = $hitbox
onready var points = line.points
var bodies = {}

func _physics_process(delta):
	for b in bodies:
		bodies[b][0] += 1
		if bodies[b][0] % 2 == 0: b.getHurt(2,0)

func _on_hitbox_body_entered(body):
	if "maxAirVelocity" in body and body.has_method("getHurt"): 
		body.getHurt(2, 0)
		bodies[body] = [0, body.maxAirVelocity - Vector2(300,250)]
		body.maxAirVelocity = Vector2(300, 250)

func _on_hitbox_body_exited(body):
	if "maxAirVelocity" in body and body.has_method("getHurt"): 
		body.maxAirVelocity += bodies[body][1]
		bodies.erase(body)

func _on_hurtbox_area_entered(area):
	if is_instance_valid(hitbox): hitbox.queue_free()
	if is_instance_valid(line): line.queue_free()
