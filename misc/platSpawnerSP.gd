extends Node2D

export var symmetrical = true
export var delay = 300
var timer = delay - 1

var L = [
	"res://blocks/boostPlat.tscn",
	"res://blocks/conveyerPlat.tscn",
	"res://blocks/defaultPlat.tscn",
	"res://blocks/burnPlat.tscn"
		]
	
func _physics_process(delta):
	timer += 1
	if timer % delay == 0:
		var numPlats = randi()%4+1
#		var pos = randi()%1720+100
		var ran = randi()%len(L)
		var midRan = randi()%len(L)
		var scl
#		var plat = load(L[ran]).instance()
		for x in range(1,numPlats+1):
			var pos = 1920/(numPlats+1) * x
			var mid = (numPlats==3 && x==2)or(numPlats==4 && x==2)or(numPlats==4 && x==3)or(numPlats==1)
			var plt = load(L[midRan]).instance() if mid else load(L[ran]).instance()
			if numPlats == 1: 
				scl = 5
				plt.patrol_x = Vector2(-400,400)
			if numPlats == 2: scl = 4.5
			if numPlats == 3: scl = 4
			if numPlats == 4: scl = 3.5
#			if mid: scl += 1
			plt.moving = true
			plt.scale = Vector2(scl,scl)
			plt.global_position = Vector2(pos, -40)
			add_child(plt)
		print("-------------")
		
#		plat.position = Vector2(pos, -40)
#		plat.scale = Vector2(3,3)
#		add_child(plat)
#		plat = load(L[ran]).instance()
#		plat.position = Vector2(1920-pos, -40)  # this shit is huge brain
#		plat.scale = Vector2(5,5)
#		if ran == 1:      # automatically randomizes conveyer directions
#			plat.direction = -1
#		add_child(plat)
