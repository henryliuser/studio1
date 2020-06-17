extends Area2D
export var damage = 3
onready var sprite = $sprite
onready var timer = $Timer
onready var tween = $Tween
var velocity = Vector2()
var rot_speed_deg = 0

func _ready():
	sprite.material = load("res://assets/Shaders/Outline.tres").duplicate()
	sprite.material.set_shader_param("width", 1)
	var c = Color(randf(), randf(), randf())
	sprite.material.set_shader_param("outline_color", c)
	tween.interpolate_property(sprite, "modulate:a", sprite.modulate.a, 
		0, timer.wait_time-0.1, Tween.TRANS_CUBIC, Tween.EASE_IN)
	timer.start()
	tween.start()

func _physics_process(delta):
	global_position += velocity*delta
	sprite.global_rotation_degrees += rot_speed_deg*delta
#	sprite.modulate.a = lerp(sprite.modulate.a, 0, 0.02)

func _on_note_body_entered(body):
	if body.has_method("getHurt"):
		body.getHurt(damage, 10, Vector2(200, -200), global_position)
		sprite.frame = 0
		$hitbox.queue_free()
		yield(get_tree().create_timer(0.2, false), "timeout")
		queue_free()

func _on_Timer_timeout():
	queue_free()
