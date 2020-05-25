extends Area2D
export var slowFactor = 1.3
var velocity = Vector2(1800,0)
var target
var stuck = false
var count = 0
onready var og_scale = scale
onready var og_pos = global_position

func _physics_process(delta):
	global_position += velocity * delta
	if stuck:
		count += 1
		if count % 40 == 0: 
			target.getHurt(1,1)
			target.modulate = Color.green
		if count >= 240 or target.dead: done()
	
func _on_poisonDart_body_entered(body):
	if body.has_method("getHurt"):
		target = body
		if "maxAirVelocity" in target:
			target.maxAirVelocity /= slowFactor
		if "maxGroundVelocity" in target:
			target.maxGroundVelocity /= slowFactor
		target.getHurt(5,5)
		stuck = true
		visible = false
	else: 
		velocity = Vector2()
		yield(get_tree().create_timer(3), "timeout")
		queue_free()
	
#	target.modulate = Color.green
#	target.omod = Color.green
#	og_pos = global_position
#	get_parent().remove_child(self)
#	body.add_child(self)
#	global_scale = og_scale
#	global_position = og_pos
#	yield(get_tree().create_timer(0.05), "timeout")
#	velocity = Vector2()
#	target.sprite.material = load("res://assets/Shaders/wiggle.tres")

	
func done():
	if "maxAirVelocity" in target:
		target.maxAirVelocity *= slowFactor
	if "maxGroundVelocity" in target:
		target.maxGroundVelocity *= slowFactor
#	target.sprite.material = null
	queue_free()
	
