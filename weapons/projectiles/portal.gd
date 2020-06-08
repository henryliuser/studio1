extends RigidBody2D
var player

func _on_Timer_timeout():
	if player != null and is_instance_valid(player): 
		player.global_position = global_position
		# do the hitbox 
