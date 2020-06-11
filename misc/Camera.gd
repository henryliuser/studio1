extends Camera2D
var player
export var lerp_weight = 0.2

func _process(delta):
	if player != null:
		global_position = lerp(position, player.global_position, lerp_weight)


