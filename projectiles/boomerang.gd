extends "res://projectiles/projectile.gd"
export var lerpWeight = 0.03

onready var target = position + Vector2(1000,0)
onready var ogPos = position

func _physics_process(delta):
	rotation_degrees += 500*delta
	position = lerp(position, target, lerpWeight)
	if abs(target.x-position.x) < 50:
		target = ogPos
	if target==ogPos and abs(target.x-position.x) < 50:
		queue_free()
