extends Node2D
onready var t = $texture
onready var p = $polish
onready var tween = $Tween
export var hoverPos = Vector2(10,-100)
export var lerpWeight = 0.4

var player
func _ready():
	t.value = 100
	p.value = 100
	player = get_node("../player")
func updateBar(value):
	tween.interpolate_property(p, "value", t.value, value, lerpWeight)
	tween.start()
	t.value = value
	
func _process(delta):
	var temp = hoverPos.x * player.currentDirection
	var pos = player.position + Vector2(temp, hoverPos.y)
	position = lerp(position, pos, 0.5)
	
