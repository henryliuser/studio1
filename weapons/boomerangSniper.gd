extends Node2D
var bulletList = []
func _physics_process(delta):
#	global_position = get_global_mouse_position()
	if Input.is_action_just_pressed("p1_fire"):
		$sprite.play("fire")
		yield(get_tree().create_timer(.3), "timeout")  # lined this shit first try
		var q = load("res://weapons/projectiles/boomerang.tscn").instance()
		q.global_position = $point.global_position
		bulletList.push_back(q)
		q.target *= get_parent().scale.x
		get_tree().get_root().add_child(q)
	for q in bulletList:
		if is_instance_valid(q) and q.has_method("unit"): # lmfao godot pls
			q.ogPos = $point.global_position

func _on_sprite_animation_finished():
	if $sprite.animation == "fire":
		$sprite.play("idle")
