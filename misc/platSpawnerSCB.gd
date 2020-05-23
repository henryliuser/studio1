extends Node2D
export var delay = 300
var timer = delay - 1
var cycle = 1
onready var folder = get_node("../platforms")
func _physics_process(delta):
#	print(get_node("../shade").get_node("player").velocity)
	timer += 1
	if timer % delay == 0:
		if cycle == 1: pattern1()
		else: pattern2()
		cycle *= -1

func pattern1():
	var plat1 = load("res://blocks/defaultPlat.tscn").instance()
	var plat2 = load("res://blocks/defaultPlat.tscn").instance()
	plat1.global_position = Vector2(350, -50)
	plat2.global_position = Vector2(1920-350, -50)
	plat1.moving = true; plat2.moving = true;
	plat1.velocity.y = 70; plat2.velocity.y = 70;
	plat1.scale = Vector2(10,7); plat2.scale = plat1.scale; plat2.scale.x *= -1
	folder.add_child(plat1); folder.add_child(plat2)
	
func pattern2():
	var plat = load("res://blocks/defaultPlat.tscn").instance()
	plat.global_position = Vector2(1920/2, -50)
	plat.moving = true; plat.velocity.y = 70
	plat.scale = Vector2(10,7)
	folder.add_child(plat)
	
	
	
