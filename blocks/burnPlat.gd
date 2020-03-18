extends KinematicBody2D
var players = {} 
export var velocity = Vector2(0,75)

func _physics_process(delta):
	position.x += velocity.x * delta
	position.y += velocity.y * delta 

	for b in players:
		players[b] += 1
		if players[b] % 60 == 0:
			b.modulate = Color.red
		if players[b] % 65 == 0:
			b.modulate = Color.white

func _on_Area2D_body_entered(body):
	players[body] = 1

func _on_Area2D_body_exited(body):
	body.modulate = Color.white
	players.erase(body)
