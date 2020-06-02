extends KinematicBody2D
export var velocity = Vector2()
export var rotation_speed = 100
func _physics_process(delta):
	global_rotation_degrees += rotation_speed * delta
	global_position += velocity * delta
	pass
func _process(delta):
#	move_and_slide(velocity)
	pass
