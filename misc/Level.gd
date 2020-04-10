extends Node2D

onready var spawns = $spawns

func _ready():
	for s in spawns.get_children():
		pass
