extends KinematicBody2D
export var velocity = Vector2(0,75)
export var is_wall = false

func _physics_process(delta):
	position += velocity * delta
