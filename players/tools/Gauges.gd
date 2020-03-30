extends Node2D
export var hoverPos = Vector2(0,-60)
export var lerpWeight = 0.5
var player

func _ready():
	player = get_node("../player")

func _process(delta):
	var temp = hoverPos.x * player.currentDirection
	var pos = player.position + Vector2(temp, hoverPos.y)
	position = lerp(position, pos, lerpWeight)
	
