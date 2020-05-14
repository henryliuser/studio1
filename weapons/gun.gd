extends "res://weapons/equippable.gd"
export var cdSeconds = 1.0
export var recoil = 300
signal shoot
var available = true  # can shoot

func _ready():
	$Timer.connect("timeout", self, "_on_Timer_timeout")
	$Timer.one_shot = true
	$Timer.wait_time = cdSeconds

func _process(_delta):
#	if available: modulate = Color.green  # debug
#	else: modulate = Color.red
	var currRot = rotation_degrees
	rotation_degrees = lerp(currRot, 0, 0.1)
	if equipped: 
		var down = Input.is_action_pressed(s + "down")
		if available:
			down = Input.is_action_pressed(s+"down")
			if Input.is_action_just_pressed(s+"fire"):
				shoot()
		if visible and down:
			var pRot = player.rotation_degrees
			var pDirec = player.currentDirection
			if player.is_on_floor():
				player.rotation_degrees = lerp(pRot, -pDirec*20, 0.1)
				rotation_degrees = lerp(currRot, -scale.x * 20, 0.1)
			else:
				player.rotation_degrees = lerp(pRot, -pDirec*-15, 0.1)
				rotation_degrees = lerp(currRot, -scale.x * -20, 0.1)
	

func _on_Timer_timeout():
	available = true
	
func shoot():
	available = false
	emit_signal("shoot")
	get_parent().update_active(type)  # updates which slot is currently being used 
	$Timer.start()
	
func _on_picked_up(p):  # connect to player when picked up so we can polish stuff like kickback and rotate
	._on_picked_up(p)
	connect("shoot", p,"_on_shoot")

	


