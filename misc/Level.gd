extends Node2D

onready var spawns = $spawns

func _ready():
	var counter = 0
	for p in ENetGlobal.players:
		var s = spawns.get_child(counter)
		p.position = s.position
		get_tree().get_root().add_child(p)
		counter += 1
