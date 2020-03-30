extends Label
var chara
func _ready():
	chara = get_node("../walker")

func _process(delta):
	rect_position = chara.position + Vector2(-32.5,-100)
