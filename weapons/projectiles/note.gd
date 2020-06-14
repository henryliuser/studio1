extends Area2D
export var damage = 5
onready var sprite = $sprite
onready var timer = $Timer
var velocity = Vector2()
var rot_speed_deg = 0

func _ready():
	sprite.material = load("res://assets/Shaders/Outline.tres").duplicate()
	sprite.material.set_shader_param("width", 0.5)
	sprite.material.set_shader_param("outline_color", Color(randi()%16777215))
	rot_speed_deg = randi()%401 - 200
	timer.start()

func _physics_process(delta):
	global_position += velocity*delta
	sprite.global_rotation_degrees += rot_speed_deg*delta

func _on_note_body_entered(body):
	if body.has_method("getHurt"):
		body.getHurt(damage, 10, Vector2(200, -200), global_position)
		queue_free()

func _on_Timer_timeout():
	queue_free()
