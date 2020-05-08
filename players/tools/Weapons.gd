extends "res://players/tools/Gauges.gd"

export var posList = {
	"tembo" : Vector2(),
	"boomerangSniper" : Vector2(),
	"meterstick" : Vector2(),
	"potassiumCannon" : Vector2()
}

func _process(_delta):
	scale.x = player.currentDirection
