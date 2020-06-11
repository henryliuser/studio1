extends "res://blocks/defaultPlat.gd"
var timer = 0
var bodies = {}

func _physics_process(_delta):
	if timer > 0: 
		timer += 1 
		for b in bodies: b.velocity.y = lerp(b.velocity.y, 0, 0.6)
		if timer >= 17:
			timer = 0
			for b in bodies: 
				if b.has_method("jet"): b.updateFuel(20)
				b.velocity.y = clamp(-bodies[b], -2400, -900) 
				b.scale.y *= 1.5

func _on_boostTrigger_body_entered(body):
	if "velocity" in body:
		if timer == 0: timer = 1
		bodies[body] = abs(body.velocity.y * 1.3)
		body.velocity /= 4
		$sprite.frame = 1


func _on_boostTrigger_body_exited(body):
	if "velocity" in body:
		bodies.erase(body)
