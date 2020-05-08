extends "res://weapons/gun.gd"
export var projectilePath = ""
onready var parent = get_parent().get_node("../player")
	
func shoot():
	.shoot()
	var q = load(projectilePath).instance()
	q.keeper = parent
	q.global_position = $Muzzle.global_position
	q.direction = parent.currentDirection
	get_tree().get_root().add_child(q)
	rotation_degrees = -30

func _physics_process(_delta):
	rotation_degrees = lerp(rotation_degrees, 0, 0.03)



