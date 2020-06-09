extends Area2D
var player
var velocity = Vector2(700,-700)
var rot_speed_deg = 300

func exit():
	$exit.visible = true
	$exit.monitoring = true
	$Tween.interpolate_property($sprite, "scale", $sprite.scale, Vector2(6,6),
		1, Tween.TRANS_BOUNCE, Tween.EASE_OUT_IN)
	$Tween.start()
	velocity = Vector2()
	rot_speed_deg = 700
	player.global_position = global_position
	if player.velocity.y > 0: player.velocity.y = 0  # only reset v.y if falling
	yield(get_tree().create_timer(0.7, false), "timeout")
	queue_free()

func _on_exit_body_entered(body):
	if body.has_method("getHurt") and body != player: 
		body.getHurt(10, 20, Vector2(500,-500), global_position)
	
func _on_portal_body_entered(body):
	exit()
	
func _physics_process(delta):
	if !$exit.visible: velocity.y += 40
	global_position += velocity * delta
	rotation_degrees += rot_speed_deg * delta
