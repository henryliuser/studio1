extends KinematicBody2D
var direction = 1
var keeper
var velocity = Vector2(direction*600,-600)
var gravity = 40
var plantedFloor = 0
var plantedWall = 0

func _ready():
	velocity.x *= direction

func _physics_process(delta):  # don't even fking ask me..
	if plantedFloor < 6 and plantedFloor > 0: 
		plantedFloor += 1
		velocity.x = 0
		velocity.y += 100
	elif plantedWall < 6 and plantedWall > 0:
		plantedWall += 1
		velocity.y = 0
		velocity.x += 100*direction
	elif plantedWall > 0 or plantedFloor > 0: velocity = Vector2()
	if is_on_floor() or is_on_wall(): velocity = Vector2()
	
	if !plantedFloor and !plantedWall:
		velocity.y += gravity 
		rotation_degrees += 600 * delta * direction
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
		if is_on_floor(): 
			plantedFloor = 1
			rotation_degrees = 0
		if is_on_wall(): 
			plantedWall = 1
			rotation_degrees = -direction * 90
		bods[body] = $sprite.play("planted")
		call_deferred("stick", body)

func yuh(x, body):  #dumb godot
	get_tree().current_scene.add_child(x)
	print(keeper.get_parent().name + " " + body.get_parent().name)
	if keeper == body:
		for h in x.hitboxes:
			h.damage /= 2
			
func stick(body):
	var x = global_position
	var y = global_rotation_degrees
	get_parent().remove_child(self)
	body.add_child(self)
	global_rotation_degrees = y
	global_position = x
	global_scale = Vector2(1, 1)
	velocity = Vector2()
