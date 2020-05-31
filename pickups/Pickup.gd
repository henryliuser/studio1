extends Area2D
onready var sprite = $sprite
onready var hover_tween = Tween.new()
onready var og_pos = sprite.position
export var hover_duration = 2.0

func _ready():
	add_child(hover_tween)
	hover_tween.repeat = true 
	hover_tween.interpolate_property(sprite, "position:y", og_pos.y + 5, og_pos.y - 5,
		hover_duration/2, Tween.TRANS_SINE, Tween.EASE_IN_OUT )
	hover_tween.interpolate_property(sprite, "position:y", og_pos.y - 5, og_pos.y + 5,
		hover_duration/2, Tween.TRANS_SINE, Tween.EASE_IN_OUT, hover_duration/2)
	hover_tween.start()

