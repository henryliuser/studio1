extends "res://blocks/defaultPlat.gd"
var timer = 0
var b = null

func _physics_process(_delta):
#	if !b.has_method("movement"):
#		if timer > 0 and timer <= 50:
#			timer += 1
#			b.scale.y -= 0.03
	if timer > 0:
		velocity.y += 40

func _on_boostTrigger_body_entered(body):
	var v = -1580
	if body.has_method("jet"):
		v /= 1.5
		body.updateFuel(100)
	if timer == 0:
		b = body
		moving = true
		body.velocity.y = v
		body.position.y -= 20
		timer = 1
		b.scale.y *= 1.5
		modulate = Color.red
	


