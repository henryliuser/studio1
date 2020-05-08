extends Node2D
export var pnum = 1
export var projectilePath = ""
export var cdSeconds = 1.5
onready var parent = get_parent().get_node("../player")
var available = true

func _ready():
	$Timer.wait_time = cdSeconds
	
func _physics_process(delta):
	if Input.is_action_just_pressed("p" + str(pnum) + "_fire") and available:
		modulate = modulate.inverted()
		available = false
		var q = load(projectilePath).instance()
		q.keeper = parent
		q.global_position = $Muzzle.global_position
		q.direction = parent.currentDirection
		get_tree().get_root().add_child(q)
		$Timer.start()

func _on_Timer_timeout():
	available = true
	modulate = modulate.inverted()
	#animation hint telegraph
