extends "res://weapons/gun.gd"
var bulletList = []

func shoot():
	available = false  # this is a bugfix, trust
	$sprite.play("fire")
	yield(get_tree().create_timer(.3), "timeout")  # lined this shit first try
	.shoot()
	var q = load("res://weapons/projectiles/boomerang.tscn").instance()
	player.velocity.x -= player.currentDirection * recoil  # kick player back
	q.global_position = $point.global_position
	q.dontTouch = player  # give it player who produced banana so it knows when to deal half damage
	bulletList.push_back(q)
	q.target *= get_parent().scale.x
	get_tree().current_scene.add_child(q)
	rotation_degrees = -30
	
func _process(_delta):
	rotation_degrees = lerp(rotation_degrees, 0, 0.1)
	for q in bulletList:
		if is_instance_valid(q) and q.has_method("unit"): # lmfao godot pls
			q.ogPos = $point.global_position

func _on_sprite_animation_finished():
	if $sprite.animation == "fire":
		$sprite.play("idle")


