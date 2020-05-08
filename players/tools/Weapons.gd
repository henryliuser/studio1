extends "res://players/tools/Gauges.gd"

func _process(_delta):
	scale.x = player.currentDirection
