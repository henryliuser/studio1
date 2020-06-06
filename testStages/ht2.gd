extends Node2D

var reached = false
onready var L = $left_start
onready var R = $right_start
func _ready():
	yield(get_tree().create_timer(15, false), "timeout")
	reached = true
	
func _physics_process(delta):
	if reached:
		pass
#		if is_instance_valid(L): L.position.x = lerp(L.position.x, -500, 0.01)
#		if is_instance_valid(R): R.position.x = lerp(R.position.x, 2420, 0.01)
#		if is_instance_valid(L): L.position.y = lerp(L.position.y, 1500, 0.01)
#		if is_instance_valid(R): R.position.y = lerp(R.position.y, 1500, 0.01)
