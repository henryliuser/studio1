extends Node2D
export var velocity = Vector2(0,75)

func _physics_process(delta):
	position += velocity * delta
