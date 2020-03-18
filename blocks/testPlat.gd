extends KinematicBody2D
export var velocity = Vector2(0,75)

func _physics_process(delta):
	position.x += velocity.x * delta
	position.y += velocity.y * delta
