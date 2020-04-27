extends Node2D

onready var spawns = $spawns

func _ready():
	var counter = 0
	for p in ENetGlobal.players:
		if (p == null):
			 continue
		var s = spawns.get_child(counter)
		p.position = s.position
		add_child(p)
		counter += 1
