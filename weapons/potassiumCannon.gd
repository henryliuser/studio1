extends "res://weapons/gun.gd"
export var projectilePath = ""
	
func shoot():
	.shoot()
	var q = load(projectilePath).instance()
	q.keeper = player
	q.global_position = $Muzzle.global_position
	q.direction = player.currentDirection
	get_tree().current_scene.add_child(q)
	rotation_degrees = -30

func _physics_process(_delta):
	rotation_degrees = lerp(rotation_degrees, 0, 0.035)

func _on_Timer_timeout():
	._on_Timer_timeout()
	rotation_degrees = 0
	


