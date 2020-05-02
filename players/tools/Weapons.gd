extends "res://players/tools/Gauges.gd"

func _process(delta):
	scale.x = player.currentDirection
