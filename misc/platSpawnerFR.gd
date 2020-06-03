extends Node2D

export var delay = 100
var timer = delay - 1

var paths = [
	"res://blocks/boostPlat.tscn",
	"res://blocks/conveyerPlat.tscn",
	"res://blocks/defaultPlat.tscn",
	"res://blocks/burnPlat.tscn"
		]

var num2chance = { 1:3, 2:4, 3:6, 4:10 }
var last_num = 1

func _physics_process(delta):
	timer += 1
	if timer % delay == 0:
		var num_plats = -1
#		if last_num != 2:  # don't get same num_plats in a row except for 2
#			while num_plats != last_num: num_plats = randi()%3+1
#		else: num_plats = randi()%3+1
		num_plats = randi()%3+1
		last_num = num_plats  # reset last_num
		print(num_plats)
		match num_plats:
			1: _1plat()
			2: _2plat()
			3: _3plat()
			4: _4plat()
		
func _1plat():
	var rand_arr = create_rand_array(num2chance[1])
	var rand = randi()%len(paths)
	var muta_chance = 0.5
	var plat = load(paths[rand]).instance()
	plat.global_position = Vector2(1920/2, -50)  # all are centered
	plat.moving = true
	while randf() < muta_chance:
#		muta_chance/1.5  # reduce chance of successive mutations
		var x = rand_arr[randi()%len(rand_arr)]
		rand_arr.remove(x)
		match x:
			0:  # x patrol
				var r = randi()%351 + 50; var neg = randi()%2
				if neg == 1: r *= -1
				plat.patrol_x = Vector2(-r, r)
			1:  # seesaw
				if paths[rand] == "res://blocks/defaultPlat.tscn": plat.is_seesaw = true
			2:  # incremental
				plat.incremental_move = true
				var r = randi()%51 + 25
				plat.patrol_y = Vector2(-r, r) 
		if len(rand_arr) == 0: break
	get_tree().current_scene.add_child(plat)

func _2plat():
	var rand_arr = create_rand_array(num2chance[1])
	var muta_chance = 0.5
	var rand = randi()%len(paths)
	var plat1 = load(paths[rand]).instance()
	var plat2 = load(paths[rand]).instance()
	plat1.moving = true; plat2.moving = true
	plat1.global_position = Vector2(randi()%961 + 100, -50)
	plat2.global_position = Vector2(1920 - plat1.global_position.x, -50)
	while randf() < muta_chance:
		var x = rand_arr[randi()%len(rand_arr)]
		rand_arr.remove(x)
		match x:
			0:  # x patrol
				var r = randi()%251 + 50; var neg = randi()%2
				if neg == 1: r *= -1
				if plat1.global_position.x < 200:   # so that it doesn't patrol off-screen
					plat1.global_position.x += 150; plat2.global_position.x -= 150
				plat1.patrol_x = Vector2(-r, r); plat2.patrol_x = Vector2(r, -r) 
			1:  # seesaw
				if paths[rand] == "res://blocks/defaultPlat.tscn":
					plat1.is_seesaw = true; plat2.is_seesaw = true
			2:  # incremental
				plat1.incremental_move = true; plat2.incremental_move = true
				var r = randi()%51 + 25
				plat1.patrol_y = Vector2(-r, r); plat2.patrol_y = Vector2(-r, r)
			3:  # walls
				plat1.is_wall = true; plat2.is_wall = true
				plat1.rotation_degrees = 90 if randf() < 0.5 else -90
				plat2.rotation_degrees = -plat1.rotation_degrees
		if len(rand_arr) == 0: break
	get_tree().current_scene.add_child(plat1)
	get_tree().current_scene.add_child(plat2)

func _3plat():
	pass

func _4plat():
	pass

func create_rand_array(x):
	var arr = []; arr.resize(x)
	for z in range(0,x): arr[z] = z
	return arr
