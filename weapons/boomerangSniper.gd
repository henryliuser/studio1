extends "res://weapons/gun.gd"
var bulletList = []

func shoot():
	.shoot()
	$sprite.play("fire")
	yield(get_tree().create_timer(.3), "timeout")  # lined this shit first try
	var q = load("res://weapons/projectiles/boomerang.tscn").instance()
	q.global_position = $point.global_position
	bulletList.push_back(q)
	q.target *= get_parent().scale.x
	get_tree().current_scene.add_child(q)
	rotation_degrees = -30
	
func _physics_process(_delta):
	rotation_degrees = lerp(rotation_degrees, 0, 0.1)
	for q in bulletList:
		if is_instance_valid(q) and q.has_method("unit"): # lmfao godot pls
			q.ogPos = $point.global_position

func _on_sprite_animation_finished():
	if $sprite.animation == "fire":
		$sprite.play("idle")


