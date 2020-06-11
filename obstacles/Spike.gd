extends KinematicBody2D
export var is_falling = false
export var damage = 15 
export var fall_acc = 80
onready var hitbox = $hitbox
onready var fallDetection = $fallDetection
var velocity = Vector2()
var falling

var bodies = {} 

func _ready():
	if is_falling: fallDetection.monitoring = true

func _physics_process(delta):
	if falling: fall()
	if not falling and $sprite2.material != null:
		$sprite2.modulate.a = lerp($sprite2.modulate.a, 0, 0.1)

func _on_hitbox_body_entered(body):
	if body.has_method("getHurt") and !bodies.has(body):
		if falling: damage *= 2
		body.getHurt(damage, 15, Vector2(400, -300), global_position)
		bodies[body] = true

func _on_fallDetection_body_entered(body):
	if body.has_method("getHurt"):
		falling = true
		$sprite2.material = load("res://assets/Shaders/Outline.tres").duplicate()
		$sprite2.material.set_shader_param("outline_color", Color.red)

func fall():
	velocity.y += fall_acc
	velocity = move_and_slide(velocity, Vector2.UP)
	if is_on_floor():
		if is_instance_valid(hitbox) and is_instance_valid(fallDetection): 
			fallDetection.queue_free()
			hitbox.queue_free()
		yield(get_tree().create_timer(0.1, false), "timeout")
		set_collision_layer_bit(0, true)
		falling = false

