extends Node2D
onready var t = $texture
onready var p = $polish
onready var tween = $Tween
export var tweening = true
export var lerpWeight = 0.4

var player
func _ready():
	t.value = 100
	p.value = 100
	
func die():
	updateBar(0)
	
func updateBar(value):
	if tweening:
		tween.interpolate_property(p, "value", t.value, value, lerpWeight)
		tween.start()
	t.value = value

	
