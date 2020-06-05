extends KinematicBody2D
export var moving = false
export var velocity = Vector2(0,75)
export var rotation_speed_deg = 0
export var is_wall = false
export var patrol_x = Vector2()
export var patrol_y = Vector2()
export var lerp_x = 0.03
export var lerp_y = 0.03
export var lee = 20
export var incremental_move = false
export var is_seesaw = false
export var seesaw_rot_speed_deg = 100

onready var sprite = $sprite

onready var og_pos = global_position
onready var x_bound = Vector2(og_pos.x + patrol_x.x, og_pos.x + patrol_x.y)
onready var y_bound = Vector2(og_pos.y + patrol_y.x, og_pos.y + patrol_y.y)
onready var x_target = x_bound.y
onready var y_target = y_bound.y

#onready var global_position = global_position  # godot wtf
onready var velo_only_pos = global_position

func _ready():
	if is_seesaw:
		sprite.material = load("res://assets/Shaders/Outline.tres")
		sprite.material.set_shader_param("outline_color", Color.lavender)


func _physics_process(delta):
	if moving: 
		global_position += velocity * delta
		if incremental_move: velo_only_pos += velocity * delta
	global_rotation_degrees += rotation_speed_deg * delta
	
	if incremental_move:
		x_bound = Vector2(velo_only_pos.x + patrol_x.x, velo_only_pos.x + patrol_x.y)
		y_bound = Vector2(velo_only_pos.y + patrol_y.x, velo_only_pos.y + patrol_y.y)
	
	if patrol_x != Vector2(): 
		global_position.x = lerp(global_position.x, x_target, lerp_x)
		if abs(global_position.x - x_bound.y) <= lee: x_target = x_bound.x
		if abs(global_position.x - x_bound.x) <= lee: x_target = x_bound.y
	if patrol_y != Vector2():
		global_position.y = lerp(global_position.y, y_target, lerp_y)
		if abs(global_position.y - y_bound.y) <= lee: y_target = y_bound.x
		if abs(global_position.y - y_bound.x) <= lee: y_target = y_bound.y
		
#	$ybound1.global_position.y = y_bound.x
#	$ybound1.modulate = Color.white 
#	$ybound2.global_position.y = y_bound.y
#	$ybound2.modulate = Color.white
#	if y_target == y_bound.x: $ybound1.modulate = Color.turquoise
#	if y_target == y_bound.y: $ybound2.modulate = Color.turquoise
	
# do all the calculation, then fr set it at the end
	if is_seesaw: seesaw(delta)

var left_count = 0; var right_count = 0
func seesaw(delta):
	if right_count > left_count: global_rotation_degrees += seesaw_rot_speed_deg * delta 
	elif left_count > right_count: global_rotation_degrees -= seesaw_rot_speed_deg * delta
func _on_seesawRight_body_entered(_body): right_count += 1
func _on_seesawRight_body_exited(_body): right_count -= 1
func _on_seesawLeft_body_entered(_body): left_count += 1
func _on_seesawLeft_body_exited(_body): left_count -= 1
