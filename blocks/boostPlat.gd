extends "res://blocks/defaultPlat.gd"
var timer = 0
var b = null

func _physics_process(_delta):
	if timer > 0 and timer <= 50:
		timer += 1
		b.scale.y -= 0.03
	if timer > 0:
		velocity.y += 40

func _on_boostTrigger_body_entered(body):
	if body.has_method("jet"):
		body.fuel = 100
	if timer == 0:
		b = body
		body.velocity.y = -1580
		body.position.y -= 20
		timer = 1
		b.scale.y += 1.5
		modulate = Color.red
	


