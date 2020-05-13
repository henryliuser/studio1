extends Tween

onready var sprite = get_parent()
onready var oPos = sprite.position

onready var weapon = sprite.get_parent()
 
func _ready():
	repeat = true
	weapon.connect("shoot", self, "use")
	interpolate_property(sprite, "position:y",
		sprite.position.y, oPos.y - 10, 
		0.3, Tween.TRANS_SINE)
	interpolate_property(sprite,"position:y",
		sprite.position.y, oPos.y + 10, 
		0.3, Tween.TRANS_SINE, 0.3)
	start()

func use():
	pass
