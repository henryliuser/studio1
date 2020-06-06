extends Node2D

export var delay = 150
var timer = delay - 1
export var horizontal = false

var paths = [
	"res://blocks/boostPlat.tscn",
	"res://blocks/conveyerPlat.tscn",
	"res://blocks/defaultPlat.tscn",
	"res://blocks/burnPlat.tscn"
		]

var num2chance = { 1:4, 2:5, 3:6, 4:10 }
var last_num = 1

func _physics_process(delta):
	timer += 1
	if timer % delay == 0:
#		var num_plats = 4
		var num_plats = randi()%len(paths)+1
		while (num_plats == last_num and last_num != 2): 
			num_plats = randi()%len(paths)+1
		last_num = num_plats  # reset last_num
		match num_plats:
			1: _1plat()
			2: _2plat()
			3: _3plat()
			4: _4plat()
#		_horizontal_1plat(-1)

func _1plat(ret = false):
	var rand_arr = create_rand_array(num2chance[1])
	var rand = randi()%len(paths)
	var muta_chance = 0.6
	var plat = load(paths[rand]).instance()
	plat.scale = Vector2(4.5, 4.5)
	plat.position = Vector2(1920/2, -150)  # all are centered
	plat.moving = true
	while randf() < muta_chance:
#		muta_chance/1.5  # reduce chance of successive mutations
		var idx = randi()%len(rand_arr)
		var x = rand_arr[idx]
		rand_arr.remove(idx)
		match x:
			0:  # x patrol
				var r = randi()%551 + 50; var neg = randi()%2
				if neg == 1: r *= -1
				plat.patrol_x = Vector2(-r, r)
			1:  # seesaw
				if paths[rand] == "res://blocks/defaultPlat.tscn": 
					plat.is_seesaw = true
			2:  # incremental
				plat.incremental_move = true
				var r = randi()%51 + 60
				plat.patrol_y = Vector2(-r, r) 
			3:  # spinning
				plat.rotation_speed_deg = randi()%101 + 100 
		if len(rand_arr) == 0: break
#	get_tree().current_scene.add_child(plat)
	add_child(plat)
	if ret: return plat

func _2plat(ret = false):
	var rand_arr = create_rand_array(num2chance[2])
	var muta_chance = 0.6
	var rand = randi()%len(paths)
	var plat1 = load(paths[rand]).instance()
	var plat2 = load(paths[rand]).instance()
	plat1.moving = true; plat2.moving = true
	plat1.position = Vector2(randi()%691 + 130, -150)
	plat2.position = Vector2(1920 - plat1.position.x, -150)
	while randf() < muta_chance:
		var idx = randi()%len(rand_arr)
		var x = rand_arr[idx]
		rand_arr.remove(idx)
		match x:
			0:  # x patrol
				var r = randi()%251 + 50; var neg = randi()%2
				if neg == 1: r *= -1
				if plat1.position.x < 200:   # so that it doesn't patrol off-screen
					plat1.position.x += 150; plat2.position.x -= 150
				plat1.patrol_x = Vector2(-r, r); plat2.patrol_x = Vector2(r, -r) 
			1:  # seesaw
				if paths[rand] == "res://blocks/defaultPlat.tscn":
					plat1.is_seesaw = true; plat2.is_seesaw = true
			2:  # incremental
				plat1.incremental_move = true; plat2.incremental_move = true
				var r = randi()%51 + 60
				plat1.patrol_y = Vector2(-r, r); plat2.patrol_y = Vector2(-r, r)
			3:  # walls
				plat1.is_wall = true; plat2.is_wall = true
				plat1.scale.x += 1; plat2.scale.x += 1
				plat1.rotation_degrees = 90 if randf() < 0.5 else -90
				plat2.rotation_degrees = -plat1.rotation_degrees
			4:  # spinning
				plat1.rotation_speed_deg = randi()%51 + 50
				plat2.rotation_speed_deg = -plat1.rotation_speed_deg
		if plat1.is_wall and plat1.is_seesaw:  # incompatible, wall takes precedence
			plat1.is_seesaw = false; plat2.is_seesaw = false; 
		if len(rand_arr) == 0: break
	plat1.scale = Vector2(4,4); plat2.scale = Vector2(-4,4);
#	get_tree().current_scene.add_child(plat1)
#	get_tree().current_scene.add_child(plat2)
	add_child(plat1)
	add_child(plat2)
	if ret: return [plat1, plat2]

func _3plat():
	var p2 = _2plat(true)
	var p1 = _1plat(true)
	p2[0].scale = Vector2(3,3); p2[1].scale = Vector2(-3,3)
	p1.scale = Vector2(4,4)

func _4plat():
	var outer = _2plat(true)
	outer[0].position.x = randi()%301 + 150
	outer[1].position.x = 1920 - outer[0].position.x
	outer[0].scale = Vector2(3.5, 3.5); outer[1].scale = Vector2(-3.5, 3.5)
	var inner = _2plat(true)
	inner[0].position.x = outer[0].position.x + randi()%401 + 200
	inner[1].position.x = 1920 - inner[0].position.x
	inner[0].scale = Vector2(3, 3); inner[1].scale = Vector2(-3,3)

func _horizontal_1plat(dir = 1, ret = false):
	var rand_arr = create_rand_array(num2chance[1])
	var rand = randi()%len(paths)
	var muta_chance = 0.4
	var plat = load(paths[rand]).instance()
	plat.scale = Vector2(4, 4)
	plat.position = Vector2(-150, randi()%881 + 100)
	if dir == -1: plat.position.x = 1920+150
	plat.moving = true
	plat.velocity = Vector2(200*dir, 0)
	while randf() < muta_chance:
#		muta_chance/1.5  # reduce chance of successive mutations
		var idx = randi()%len(rand_arr)
		var x = rand_arr[idx]
		rand_arr.remove(idx)
		match x:
			0:  # x patrol
				var r = randi()%351 + 50; var neg = randi()%2
				if neg == 1: r *= -1
				plat.patrol_y = Vector2(-r, r)
			1:  # seesaw
				if paths[rand] == "res://blocks/defaultPlat.tscn": 
					plat.is_seesaw = true  # let pick scale
			2:  # incremental
				plat.incremental_move = true
				var r = randi()%51 + 60
				plat.patrol_x = Vector2(-r, r) 
			3:  # spinning
				plat.rotation_speed_deg = randi()%51 + 30
		if len(rand_arr) == 0: break
#	get_tree().current_scene.add_child(plat)
	add_child(plat)
	if ret: return plat

func create_rand_array(x):
	var arr = []; arr.resize(x)
	for z in range(0,x): arr[z] = z
	return arr
