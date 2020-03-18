extends Node2D

export var symmetrical = true
var timer = 0

var L = [
	"res://Blocks/boostPlat.tscn",
	"res://Blocks/conveyerPlat.tscn",
	"res://Blocks/defaultPlat.tscn"
		]

func _ready():
	randomize()

func _physics_process(delta):
	timer += 1
	if timer % 200 == 0:
		var pos = randi()%1720+100
		var ran = randi()%3
		var plat = load(L[ran]).instance()
		plat.position = Vector2(pos, 0)
		plat.scale.x = 3
		add_child(plat)
		plat = load(L[ran]).instance()
		plat.position = Vector2(1920-pos, 0)  # this shit is huge brain
		if ran == 1:      # automatically randomizes conveyer directions
			plat.direction = -1
		plat.scale.x = 3
		add_child(plat)
