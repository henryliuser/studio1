extends KinematicBody2D
var b = null
export var velocity = Vector2(0,50)
export var direction = 1
export var speed = 200

onready var ic = $icon

func _ready():
	ic.rotation_degrees = direction * 90

func _physics_process(delta):
	if not b == null:
		b.velocity.x = direction * speed
	position.x += velocity.x * delta
	position.y += velocity.y * delta

func _on_trigger_body_entered(body):
	b = body
	b.acceleration = 350
	b.maxGroundVelocity.x = 500

func _on_trigger_body_exited(body):  #no fucking clue why this works...
	b.acceleration = 80
	b.maxGroundVelocity.x = 400
	b = null
