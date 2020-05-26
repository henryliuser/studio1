extends Area2D
export var slowFactor = 1.3
var velocity = Vector2(1800,0)
var target
var stuck = false
var count = 0
var duration = 500
onready var og_scale = scale
onready var og_pos = global_position

func _physics_process(delta):
	if not stuck: duration -= 1
	if duration <= 0: queue_free()
	global_position += velocity * delta
	if stuck:
		count += 1
		if count % 50 == 0: 
			target.getHurt(1,0)
			target.modulate = Color.green
		if count >= 250 or target.dead: done()
	
func _on_poisonDart_body_entered(body):
	$hitbox.queue_free()
	velocity = Vector2()
	if body.has_method("getHurt"):
		global_position = Vector2(-400,400)
		target = body
		if "maxAirVelocity" in target:
			target.maxAirVelocity.x /= slowFactor
		if "maxGroundVelocity" in target:
			target.maxGroundVelocity.x /= slowFactor
		target.getHurt(5,5,Vector2(50,0),og_pos)
		stuck = true
		visible = false
#		yield(get_tree().create_timer(5), "timeout")
#		done()
	else: 
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
		target.maxAirVelocity.x *= slowFactor
	if "maxGroundVelocity" in target:
#		print(target.maxGroundVelocity.x)
		target.maxGroundVelocity.x *= slowFactor
#		print(target.maxGroundVelocity.x)
#	target.sprite.material = null
	queue_free()
	
