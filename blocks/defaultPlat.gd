extends StaticBody2D

func _physics_process(delta):
	position.y = position.y + 1
	position.x = position.x + 0.2
	if position.y > 1230:
		position.y = -150
		

