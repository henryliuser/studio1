extends "res://blocks/defaultPlat.gd"
export var direction = 1
export var speed = 200
var players = {}

func _ready():
	scale.x *= -direction

func _physics_process(_delta):
	if len(players) > 0:
		for b in players:
			b.velocity.x = direction * speed

func _on_trigger_body_entered(body):
	players[body] = true
	body.acceleration += 270
	body.maxGroundVelocity.x += 100

func _on_trigger_body_exited(body):  #no fucking clue why this works...
	body.acceleration -= 270
	body.maxGroundVelocity.x -= 100
	players.erase(body)
