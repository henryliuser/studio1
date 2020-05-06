extends KinematicBody2D
var direction = 1
var keeper
onready var velocity = Vector2(direction*600,-600)
var planted = false
func _physics_process(delta):
	velocity.y += 40
	if is_on_floor() or is_on_wall(): 
		planted = true
		velocity.x = 0
	velocity = move_and_slide(velocity, Vector2(0,-1))

func _on_trigger_body_entered(body):
	var x = load("res://weapons/projectiles/explosion.tscn").instance()
	x.global_position = global_position
	call_deferred("yuh", x, body)
	queue_free()

func yuh(x, body):  #dumb godot
	get_tree().get_root().add_child(x)
	if keeper == body:
		for h in x.hitboxes:
			h.damage /= 2
