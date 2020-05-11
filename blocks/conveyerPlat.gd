extends "res://blocks/defaultPlat.gd"
export var direction = 1
export var speed = 200
var players = {}

func _ready():
	scale.x *= -direction

func _physics_process(delta):
	if len(players) > 0:
		for b in players:
			if is_wall:
				if b.has_method("calcWalls") and (b.L or b.R):
					b.velocity.y += 1.5 *direction * speed
				elif b.has_method("getHurt"):
					b.velocity.y += direction * speed * 0.4
				else:
					b.global_position.y += direction * speed * delta
			elif b.has_method("getHurt"):  #for characters
				b.velocity.x = direction * speed
			else:  # for other objects 
				b.global_position.x += direction * speed * delta

func _on_trigger_body_entered(body):
	players[body] = true
	if body.has_method("getHurt"):
		body.acceleration += 270
		body.maxGroundVelocity.x += 100

func _on_trigger_body_exited(body):  #no fucking clue why this works...
	if body.has_method("getHurt"):
		body.acceleration -= 270
		body.maxGroundVelocity.x -= 100
	players.erase(body)
