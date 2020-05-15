extends "res://weapons/melee.gd"

func _ready():
	$AnimationPlayer.get_animation("hit").length = 0.55

func hit():
	.hit()
	var walkerVelo = player.velocity.y if player.name_id == "walker" else 0
	player.sprite.rotation_degrees = player.currentDirection * 20
	player.velocity.x = player.currentDirection * 1700
	player.velocity.y = 0
	player.melee_movement(10)
	yield(get_tree().create_timer(1.0/6), "timeout")
	player.velocity.y = walkerVelo/3

