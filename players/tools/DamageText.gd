extends Node2D
onready var tween = $Tween
var halfWay = false

func _ready():
	tween.interpolate_property(self, "scale", scale, 
		Vector2(1,1), 0.2, Tween.TRANS_SINE)
	tween.interpolate_property(self, "position:y", position.y,
		position.y - 50, 0.2, Tween.TRANS_CUBIC)
	tween.start()

func _on_Tween_tween_completed(object, key):
	if halfWay == false:
		yield(get_tree().create_timer(.2), "timeout") 
		tween.interpolate_property(self, "scale", scale,
			Vector2(0.1,0.1), 0.2, Tween.TRANS_SINE)
		tween.start()
		halfWay = true
	else: 
		queue_free()

func set_text(txt):
	$DamageText.text = txt
