extends KinematicBody2D
var timer = 0
var players = {} 

func _physics_process(delta): 
	if timer > 0:
		timer += 1
	for b in players:
		if timer % 60 == 0:
			b.modulate = Color.red
		if timer % 65 == 0:
			b.modulate = Color.white

func _on_Area2D_body_entered(body):
	players[body] = 1
	timer = 1

func _on_Area2D_body_exited(body):
	body.modulate = Color.white
	timer = 0
	players.erase(body)
