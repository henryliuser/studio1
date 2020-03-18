extends KinematicBody2D
export var velocity = Vector2(0,50)
export var direction = 1
export var speed = 200
var players = {}
onready var ic = $icon

func _ready():
	ic.rotation_degrees = direction * 90

func _physics_process(delta):
	if len(players) > 0:
		for b in players:
			b.velocity.x = direction * speed
	position.x += velocity.x * delta
	position.y += velocity.y * delta

func _on_trigger_body_entered(body):
	players[body] = true
	body.acceleration += 270
	body.maxGroundVelocity.x += 100

func _on_trigger_body_exited(body):  #no fucking clue why this works...
	body.acceleration -= 270
	body.maxGroundVelocity.x -= 100
	players.erase(body)
