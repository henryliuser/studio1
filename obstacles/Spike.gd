extends KinematicBody2D
export var is_falling = false
export var damage = 15 
export var fall_acc = 80
onready var hitbox = $hitbox
var velocity = Vector2()
var falling

func _ready():
	if is_falling: $fallDetection.monitoring = true

func _physics_process(delta):
	if falling: fall()

func _on_hitbox_body_entered(body):
	if body.has_method("getHurt"):
		if falling: damage *= 2
		body.getHurt(damage, 15, Vector2(400, -300), global_position)
		

func _on_fallDetection_body_entered(body):
	if body.has_method("getHurt"):
		falling = true
		
func fall():
	velocity.y += fall_acc
	velocity = move_and_slide(velocity, Vector2.UP)
	if is_on_floor():
		falling = false
		if is_instance_valid(hitbox): 
			hitbox.queue_free()
		yield(get_tree().create_timer(0.1, false), "timeout")
		set_collision_layer_bit(0, true)
