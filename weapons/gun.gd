extends Node2D
export var pnum = 1
export var projectilePath = ""
onready var parent = get_parent().get_node("../player")
func _physics_process(delta):
	if Input.is_action_just_pressed("p" + str(pnum) + "_fire"):
		var q = load(projectilePath).instance()
		q.keeper = parent
		q.global_position = $Muzzle.global_position
		q.direction = parent.currentDirection
		get_tree().get_root().add_child(q)

