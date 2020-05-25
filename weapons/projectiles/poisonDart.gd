extends Area2D
export var slowFactor = 1.2
var velocity = Vector2()
var target
var stuck = false
var count = 0
onready var og_scale = scale

func _physics_process(delta):
	global_position += velocity * delta
	if stuck:
		count += 1
		if count % 5 == 0: target.getHurt(5,2)
		if count >= 240: done()
	
func _on_poisonDart_body_entered(body):
	target = body
	if "maxAirVelocity" in target:
		target.maxAirVelocity /= slowFactor
	if "maxGroundVelocity" in target:
		target.maxGroundVelocity /= slowFactor
	target.getHurt(5,5)
	stuck = true
	get_parent().remove_child(self)
	body.add_child(self)
	global_scale = og_scale
	yield(get_tree().create_timer(0.05), "timeout")
	velocity = Vector2()
	
func done():
	if "maxAirVelocity" in target:
		target.maxAirVelocity *= slowFactor
	if "maxGroundVelocity" in target:
		target.maxGroundVelocity *= slowFactor
	queue_free()
	
