extends KinematicBody2D
 
onready var front_check = $FrontCheck
onready var low_mid_check = $LowMidCheck
onready var high_mid_check = $HighMidCheck
onready var back_check = $BackCheck
 
onready var front_legs = $FrontLegs.get_children()
onready var back_legs = $BackLegs.get_children()
 
export var x_speed = 100
export var y_speed = 40
 
export var step_rate = 0.1
var time_since_last_step = 0
var cur_f_leg = 0
var cur_b_leg = 0
var use_front = false
 
func _ready():
	front_check.force_raycast_update()
	back_check.force_raycast_update()
	for i in range(8):
		step()
 
func _physics_process(delta):
	var x = 0
	if Input.is_action_pressed("p1_left"):
		x = -x_speed
	elif Input.is_action_pressed("p1_right"):
		x = x_speed
	else: 
		x = 0

	var move_vec = Vector2(x, 0)
	if high_mid_check.is_colliding():
		move_vec.y = -y_speed
	elif !low_mid_check.is_colliding():
		move_vec.y = y_speed
	move_and_slide(move_vec)
 
func _process(delta):
	time_since_last_step += delta
#	if Input.is_action_pressed("p1_left") or Input.is_action_pressed("p1_right"):
	if time_since_last_step >= step_rate:
		time_since_last_step = 0
		step()
	
 
func step():
	var leg = null
	var sensor = null
	if use_front:
		leg = front_legs[cur_f_leg]
		cur_f_leg += 1
		cur_f_leg %= front_legs.size()
		sensor = front_check
	else:
		leg = back_legs[cur_b_leg]
		cur_b_leg += 1
		cur_b_leg %= back_legs.size()
		sensor = back_check
	use_front = !use_front
   
	var target = sensor.get_collision_point()
	leg.step(target)
