extends Node2D

onready var spawns = $spawns

func _ready():
	var counter = 0
	for s in spawns.get_children():
		var p = ENetGlobal.players[counter]
		p.position = s.position
		p.set_name(str(p.localNum) + "-" + str(p.netID) )
		p.set_network_master(p.netID)
		get_parent().add_child(p)
		counter += 1
