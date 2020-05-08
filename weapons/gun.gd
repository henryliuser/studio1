extends Node2D
export var cdSeconds = 1.0
export var pnum = 1
var available = true
func _ready():
	$Timer.connect("timeout", self, "_on_Timer_timeout")
	$Timer.wait_time = cdSeconds

func _process(delta):
	if Input.is_action_just_pressed("p" + str(pnum) + "_fire") and available:
		shoot()
		
func _on_Timer_timeout():
	available = true
	
func shoot():
	available = false
	$Timer.start()

