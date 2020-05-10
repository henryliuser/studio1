extends "res://blocks/defaultPlat.gd"
var players = {} 
export var stun = 10
func _physics_process(_delta):
	for b in players:
		players[b] += 1
		if players[b] % 25 == 0:
			b.getHurt(5, stun)

func _on_burnTrigger_body_entered(body):
	players[body] = 1
	body.getHurt(5, stun)

func _on_burnTrigger_body_exited(body):
	players.erase(body)
