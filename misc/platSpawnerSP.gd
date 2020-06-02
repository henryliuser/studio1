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
		var first_random_for_2 = randi()%660+100 if numPlats == 2 else 0
		for x in range(1,numPlats+1):
			var pos = 1920/(numPlats+1) * x
			var mid = (numPlats==3 && x==2)or(numPlats==4 && x==2)or(numPlats==4 && x==3)or(numPlats==1)
			var plt = load(L[midRan]).instance() if mid else load(L[ran]).instance()
			if numPlats == 1: 
				scl = 5
				plt.patrol_x = Vector2(-400,400)
			if numPlats == 2: 
				if x == 1: pos = first_random_for_2
				if x == 2: pos = 1920-first_random_for_2
				scl = 4.5
			if numPlats == 3: scl = 4
			if numPlats == 4:
				if x == 2: plt.patrol_x = Vector2(100,-200)  
				if x == 3: plt.patrol_x = Vector2(-100,200)
				scl = 3.5
#			if mid: scl += 1
			plt.moving = true
			plt.scale = Vector2(scl,scl)
			plt.global_position = Vector2(pos, -40)
			add_child(plt)



