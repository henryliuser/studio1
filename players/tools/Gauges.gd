extends Node2D
onready var hoverPos = position
export var lerpWeight = 0.45
var player

func _ready():
	player = get_node("../player")

func _process(_delta):
	var temp = hoverPos.x * player.currentDirection
	if "storedDirection" in player: temp = hoverPos.x * player.storedDirection
	var pos = player.position + Vector2(temp, hoverPos.y)
	position = lerp(position, pos, lerpWeight)
	
