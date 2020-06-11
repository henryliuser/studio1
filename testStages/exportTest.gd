extends Node2D
onready var cam = $Camera2D
onready var players = $Players.get_children()
var current = 0

func _ready():
	cam.player = players[0].get_node("player")

func _process(delta):
	if Input.is_action_just_pressed("debug_change_camera"):
		players[current].get_node("player").localNum = 2
		current += 1
		if current >= len(players): current = 0
		players[current].get_node("player").localNum = 1
		cam.player = players[current].get_node("player")

		
		
