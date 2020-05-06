extends Node2D
var keeper
onready var hitboxes = $hitboxes.get_children()
export var life = 15
func _ready():
	$sprite.play("default")
func _process(delta):
	life -= 1
	if life == 0: queue_free()
