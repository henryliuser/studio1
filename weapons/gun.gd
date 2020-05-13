extends "res://weapons/equippable.gd"
export var cdSeconds = 1.0
export var recoil = 300
signal shoot
var available = true  # can shoot

func _ready():
	$Timer.connect("timeout", self, "_on_Timer_timeout")
	$Timer.wait_time = cdSeconds

func _process(_delta):
	if equipped and available:
		if Input.is_action_just_pressed("p" + str(pnum) + "_fire"):
			shoot()
		
func _on_Timer_timeout():
	available = true
	
func shoot():
	available = false
	emit_signal("shoot")
	get_parent().update_active(type)  # updates which slot is currently being used 
	$Timer.start()
	
func _on_picked_up():  # connect to player when picked up so we can polish stuff like kickback and rotate
	connect("shoot",get_parent().get_node("../player"),"_on_shoot")

	


