extends KinematicBody2D
export var moving = false
export var velocity = Vector2(0,75)
export var is_wall = false
export var patrol_to = Vector2()
export var patrol_time = 0
onready var tween = $Tween
onready var og_pos = global_position

func _ready():
	if patrol_time > 0:
		tween.interpolate_property(self, "global_position", global_position, 
		global_position + patrol_to, patrol_time, Tween.TRANS_CUBIC, Tween.EASE_OUT)
		tween.interpolate_property(self, "global_position", global_position + patrol_to,
		global_position, patrol_time, Tween.TRANS_CUBIC, Tween.EASE_OUT, patrol_time)
		tween.repeat = true
		tween.start()
#	var eXtents = Vector2(og_pos.x + patrol_x.x, og_pos.x + patrol_x.y)
#	var eYtents = Vector2(og_pos.y + patrol_y.x, og_pos.y + patrol_y.y)
#	if patrol_x_time != 0:
#		tween.interpolate_property(self, "global_position:x", og_pos.x,
#		eXtents.y, patrol_x_time, Tween.TRANS_CUBIC, Tween.EASE_OUT)
#		tween.interpolate_property(self, "global_position:x", eXtents.y,
#		eXtents.x, patrol_x_time, Tween.TRANS_CUBIC, Tween.EASE_OUT, patrol_x_time)
#		tween.interpolate_property(self, "global_position:x", eXtents.x,
#		og_pos.x, patrol_x_time, Tween.TRANS_CUBIC, Tween.EASE_OUT, 2*patrol_x_time)
#	tween.repeat = true
#	tween.start()


func _physics_process(delta):
	if moving: global_position += velocity * delta
