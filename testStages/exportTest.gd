extends Node2D
onready var cam = $Players/walker/Camera2D
onready var players = $Players.get_children()
var current = 1

func _process(delta):
	if Input.is_action_just_pressed("debug_change_camera"):
		cam.get_parent().remove_child(cam)
		players[current].get_node("player").localNum = 2
		current += 1
		if current >= len(players): current = 0
		players[current].add_child(cam)
		players[current].get_node("player").localNum = 1
		cam.player = players[current].get_node("player")
		
		
