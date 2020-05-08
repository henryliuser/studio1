extends KinematicBody2D
var direction = 1
var keeper
onready var velocity = Vector2(direction*600,-600)
var gravity = 40
var plantedFloor = 0
var plantedWall = 0
func _physics_process(delta):  # don't even fking ask me..
	if plantedFloor < 6 and plantedFloor > 0: 
		plantedFloor += 1
		fix_rotation()
		velocity.x = 0
		velocity.y += 100
	elif plantedWall < 6 and plantedWall > 0:
		plantedWall += 1
		fix_rotation()
		velocity.y = 0
		velocity.x += 100*direction
	elif plantedWall > 0 or plantedFloor > 0: velocity = Vector2()
	if is_on_floor() or is_on_wall(): velocity = Vector2()
	
	if !plantedFloor and !plantedWall:
		velocity.y += gravity
		rotation_degrees += gravity*3 * delta
		if rotation_degrees >= 360: rotation_degrees -= 360
	velocity = move_and_slide(velocity, Vector2(0,-1))

var bods = {}
func _on_trigger_body_entered(body):
	if body.has_method("getHurt"):
		var x = load("res://weapons/projectiles/explosion.tscn").instance()
		x.global_position = global_position
		call_deferred("yuh", x, body)
		queue_free()
	elif !bods.has(body):
#		add_collision_exception_with(body)
		if is_on_floor(): plantedFloor = 1
		if is_on_wall(): plantedWall = 1
		bods[body] = 1
		call_deferred("stick", body)
		

func yuh(x, body):  #dumb godot
	get_tree().current_scene.add_child(x)
	if keeper == body:
		for h in x.hitboxes:
			h.damage /= 2
			
func fix_rotation():
	var x = rotation_degrees
	if x >= 315 or x < 45: rotation_degrees = 0
	elif x >= 45 and x < 135: rotation_degrees = 90
	elif x >= 135 and x < 225: rotation_degrees = 180
	elif x >= 225 and x < 315: rotation_degrees = 270
	else: rotation_degrees = 0

func stick(body):
	var x = global_position
	var y = global_rotation_degrees
	get_parent().remove_child(self)
	body.add_child(self)
	global_rotation_degrees = y
	global_position = x
	global_scale = Vector2(0.75,0.75)
	velocity = Vector2()
