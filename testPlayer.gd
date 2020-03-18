extends KinematicBody2D
var velocity = Vector2()

func _physics_process(delta):
	if Input.is_action_pressed("p_left"):
		velocity.x = -400
	elif Input.is_action_pressed("p_right"):
		velocity.x = 400
	else:
		velocity.x = lerp(velocity.x, 0, 0.1);
		if abs(velocity.x) < 1: 
			velocity.x = 0
		
	if not is_on_floor():
		velocity.y += 20
	else:
		velocity.y = 1
		

	if is_on_floor() && Input.is_action_just_pressed("p_jump"):
		velocity.y = -600
	velocity = move_and_slide(velocity, Vector2(0, -1))
