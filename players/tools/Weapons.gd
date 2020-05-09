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

func swap(weapon):  # for use outside of this node, by weapons
	add_child(weapon)
	var x; var index
	if weapon.type == 2: index = active
	else: index = weapon.type
	x = slots[index]
	slots[index] = weapon
	if x != null:
		var pos = x.global_position
		remove_child(x)
		get_tree().current_scene.add_child(x)
		x.global_position = pos
		x._on_dropped()  # do what happens when u drop the thing
		
	update_active(index)

func update_active(type):
	active = type
	if slots[0] != null: slots[0].visible = false
	if slots[1] != null: slots[1].visible = false
	slots[active].visible = true
