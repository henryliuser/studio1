extends Node2D
onready var tween = $Tween
var real_scale = Vector2(1,1)
var halfWay = false
var haltDuration = 0.2

func _ready():
	tween.interpolate_property(self, "scale", scale, 
		real_scale, 0.2, Tween.TRANS_SINE)
	tween.interpolate_property(self, "position:y", position.y,
		position.y-50, 0.2, Tween.TRANS_CUBIC)
	tween.start()

func _on_Tween_tween_completed(_object, _key):
	if halfWay == false:
		yield(get_tree().create_timer(haltDuration), "timeout") 
		tween.interpolate_property(self, "scale", scale,
			Vector2(0.1,0.1), 0.2, Tween.TRANS_SINE)
		tween.start()
		halfWay = true
	else: 
		queue_free()

var using
func set_text(txt):
	if int(txt) >= 25:
		big_damage()
	else: using = $DamageText
	using.text = str(txt)

func big_damage():
	using = $BigDamage
	using.visible = true
	$DamageText.visible = false
	haltDuration = 0.6
	
#func chain(dmg):
#	set_text(str(int($DamageText.text)+dmg))
#	tween.interpolate_property(self, "scale", scale,
#		scale + Vector2(0.5,0.5), 0.1)
