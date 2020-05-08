extends Node2D
export var pnum = 1
onready var itemName = name
var equipped = false
var player
func _ready():
	$equipRadius.set_collision_layer(32)

func _physics_process(_delta):  # needs to be physics process cuz order
	if name == "boomerangSniper": $sprite.material = null
	if equipped: position = lerp(position,player.Weapons.posList[itemName], 0.3)

func activate(p):  # is within range to be picked up by a player
	if not equipped:
		if name == "boomerangSniper": $sprite.material = load("res://assets/Shaders/Outline.tres")
		if Input.is_action_just_pressed("p" + str(p.localNum) + "_equip"):
			player = p
			equipped = true
			pnum = p.localNum
			var x = global_position
			if name == "boomerangSniper": $sprite.material = null
			get_parent().remove_child(self)
			p.Weapons.add_child(self)
			global_position = x
	
