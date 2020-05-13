extends "res://players/tools/Gauges.gd"

var active = 0
var slots = {
	0 : null,
	1 : null
}

export var posList = {
	"tembo" : Vector2(),
	"boomerangSniper" : Vector2(),
	"meterstick" : Vector2(),
	"potassiumCannon" : Vector2()
}

func _process(_delta):
	scale.x = player.currentDirection
	
func _ready():
	get_node("../player").connect("die", self, "die")

func swap(weapon):  # for use outside of this node, by weapons
	add_child(weapon)
	var x; var index
	if weapon.type == 2: index = active
	else: index = weapon.type
	x = slots[index]
	slots[index] = weapon
	drop(x)
	update_active(index)

func drop(x, pos:Vector2=Vector2(9999,9999)):
	if x != null:
		print(x.name)
		if pos == Vector2(9999,9999): pos = x.global_position
		remove_child(x)
		get_tree().current_scene.add_child(x)
		x.global_position = pos
		x._on_dropped()  # do what happens when u drop the thing

func die():
	var count = 0
	var left; var right;
	if slots[0] != null:
		count += 1; left = slots[0]
	if slots[1] != null:
		count += 1 ; right = slots[1]
	if count == 0: return
	elif count == 1: 
		if left != null: drop(left)
		else: drop(right)
	else:
		drop(left, global_position - Vector2(50,0))
		drop(right, global_position + Vector2(50,0))
	

func update_active(type):
	active = type
	if slots[0] != null: slots[0].visible = false
	if slots[1] != null: slots[1].visible = false
	slots[active].visible = true
