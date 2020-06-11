extends KinematicBody2D
export var is_falling = false
export var is_missile = false
export var damage = 15 
export var fall_acc = 80
onready var hitbox = $hitbox
onready var fallDetection = $fallDetection
var velocity = Vector2()
var falling = false
var missile_spd = 0
var missile_unitvec = Vector2()

var bodies = {} 

func _ready():
	if is_falling or is_missile: fallDetection.monitoring = true

func _physics_process(delta):
	if falling: fall()
	if not falling and $sprite2.material != null:
		$sprite2.modulate.a = lerp($sprite2.modulate.a, 0, 0.1)

func _on_hitbox_body_entered(body):
	if body.has_method("getHurt") and !bodies.has(body):
		if falling: 
			damage *= 2
			bodies[body] = true
		body.getHurt(damage, 15, Vector2(400, -300), global_position)


func _on_fallDetection_body_entered(body):
	if body.has_method("getHurt"):
		if is_falling: falling = true
		if is_missile: 
			missile_unitvec = Vector2(cos(global_rotation+90), sin(global_rotation+90))
		$sprite2.material = load("res://assets/Shaders/Outline.tres").duplicate()
		$sprite2.material.set_shader_param("outline_color", Color.red)
		Global.call_deferred("attach", self, get_tree().current_scene)

func fall():
	if not is_missile:
		velocity.y += fall_acc
		velocity = move_and_slide(velocity, Vector2.UP)
	elif is_missile:
		missile_spd += fall_acc
		velocity = move_and_slide(missile_unitvec*missile_spd, Vector2.UP)
		
	for x in range(get_slide_count()):
		var c = get_slide_collision(x)
		if c != null: 
			c = c.collider
			if c.has_method("seesaw") and c != get_parent(): 
				Global.call_deferred("attach",self,c)
				if is_instance_valid(hitbox) and is_instance_valid(fallDetection): 
					fallDetection.queue_free()
					hitbox.queue_free()
				yield(get_tree().create_timer(0.1, false), "timeout")
				set_collision_layer_bit(0, true)
				falling = false


