extends KinematicBody2D
var players = {} 
export var velocity = Vector2(0,75)

func _physics_process(delta):
	position += velocity * delta

	for b in players:
		players[b] += 1
		if players[b] % 30 == 0:
			b.modulate = Color.red
		if players[b] % 33 == 0:
			b.modulate = Color.white

func _on_burnTrigger_body_entered(body):
	players[body] = 1

func _on_burnTrigger_body_exited(body):
	body.modulate = Color.white
	players.erase(body)
