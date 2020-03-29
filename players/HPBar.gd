extends Node2D
onready var t = $texture
onready var p = $polish
onready var tween = $Tween
var player
func _ready():
	t.value = 100
	p.value = 100
	player = get_node("../player")
func updateBar(value):
	tween.interpolate_property(p, "value", t.value, value, 0.4)
	tween.start()
	t.value = value
	
func _process(delta):
	var pos = player.position + Vector2(10*player.currentDirection, -100)
	position = lerp(position, pos, 0.5)
	
