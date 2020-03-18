extends Area2D

var timer = 0
var b = null
#
#func _ready():
#	Engine.time_scale = 0.5

func _physics_process(delta):
	if timer > 0 and timer <= 50:
		timer += 1
		b.scale.y -= 0.03
	if timer > 0:
		position.y += 250*delta

func _on_detect_body_entered(body):
	b = body
	print("detect " +str(name) + " " + body.name)
	if timer == 0:
		body.velocity.y = -790
		body.position.y -= 30
		body.launch = true
		timer = 1
		b.scale.y += 1.5
		modulate = Color.red
	
func _on_detect_body_exited(body):
	print("exit " + str(name))
	remove_child(body)
