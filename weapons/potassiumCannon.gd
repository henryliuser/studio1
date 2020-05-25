extends "res://weapons/gun.gd"
export var projectilePath = ""
	
func shoot():
	.shoot()
	var q = load(projectilePath).instance()
	q.keeper = player  # does half damage if triggered by self
	q.global_position = $Muzzle.global_position
	q.direction = player.currentDirection
	player.rotation_degrees -= player.currentDirection*25
	player.global_position.x -= player.currentDirection*20
	if Input.is_action_pressed(s+"down"):
		q.velocity /= 1.3
	get_tree().current_scene.add_child(q)
	rotation_degrees -= 30

func _physics_process(_delta):
	rotation_degrees = lerp(rotation_degrees, 0, 0.035)

func _on_Timer_timeout():
	._on_Timer_timeout()
	rotation_degrees = 0
	


