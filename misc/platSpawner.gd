extends Node2D

export var symmetrical = true
export var delay = 250
var timer = delay - 1

var L = [
	"res://blocks/boostPlat.tscn",
	"res://blocks/conveyerPlat.tscn",
	"res://blocks/defaultPlat.tscn",
	"res://blocks/burnPlat.tscn"
		]

func _ready():
	randomize()
	
func _physics_process(delta):
	timer += 1
	if timer % delay == 0:
		var pos = randi()%1720+100
		var ran = randi()%len(L)
		var plat = load(L[ran]).instance()
		plat.moving = true
		plat.position = Vector2(pos, -40)
		plat.scale = Vector2(4,4)
		add_child(plat)
		plat = load(L[ran]).instance()
		plat.moving = true
		plat.scale = Vector2(4,4)
		plat.position = Vector2(1920-pos, -40)  # this shit is huge brain
		if ran == 1:      # automatically randomizes conveyer directions
			plat.direction = -1
		add_child(plat)
