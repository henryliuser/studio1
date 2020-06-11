extends KinematicBody2D
export var damage = 10

var fade = false
func _physics_process(delta):
	move_and_slide(Vector2(0, 200), Vector2.UP)
	if fade:
		modulate.a = lerp(modulate.a, 0, 0.1)

func _on_hitbox_body_entered(body):
	if body.has_method("getHurt"):
		$sprite.frame = 1
		$sprite.material = load("res://assets/Shaders/Outline.tres").duplicate()
		$sprite.material.set_shader_param("outline_color", Color.red)
		$sprite.material.set_shader_param("width", 1)
		body.getHurt(damage, 60)
		body.velocity = Vector2()
		body.global_position.x = global_position.x
		$hitbox.set_deferred("monitoring", false)
		yield(get_tree().create_timer(1, false), "timeout")
		fade = true
		yield(get_tree().create_timer(1, false), "timeout")
		queue_free()
