extends Node2D

export var symmetrical = true
var timer = 0

var L = [
	"res://Blocks/boostPlat.tscn",
	"res://Blocks/conveyerPlat.tscn",
	"res://Blocks/defaultPlat.tscn",
	"res://Blocks/burnPlat.tscn"
		]

func _ready():
#	randomize()
	pass
	
func _physics_process(delta):
	timer += 1
	if timer % 150 == 0:
		var pos = randi()%1720+100
		var ran = randi()%len(L)
		var plat = load(L[ran]).instance()
		plat.position = Vector2(pos, -40)
		add_child(plat)
		plat = load(L[ran]).instance()
		plat.position = Vector2(1920-pos, -40)  # this shit is huge brain
		if ran == 1:      # automatically randomizes conveyer directions
			plat.direction = -1
		add_child(plat)
