extends KinematicBody2D
export var moving = false
export var velocity = Vector2(0,75)
export var is_wall = false
export var patrol_x = Vector2()
export var patrol_y = Vector2()
export var lerp_x = 0.03
export var lerp_y = 0.03
export var lee = 20

onready var og_pos = global_position
onready var x_bound = Vector2(og_pos.x + patrol_x.x, og_pos.x + patrol_x.y)
onready var y_bound = Vector2(og_pos.y + patrol_y.x, og_pos.y + patrol_y.y)
onready var x_target = x_bound.y
onready var y_target = y_bound.y

onready var actual_pos = global_position  # godot wtf
func _physics_process(delta):
	if moving: 
		actual_pos += velocity * delta
	if patrol_x != Vector2(): 
		actual_pos.x = lerp(actual_pos.x, x_target, lerp_x)
		if abs(global_position.x - x_bound.y) <= lee: x_target = x_bound.x 
		if abs(global_position.x - x_bound.x) <= lee: x_target = x_bound.y
	if patrol_y != Vector2():
		actual_pos.y = lerp(actual_pos.y, y_target, lerp_y)
		if abs(global_position.y - y_bound.y) <= lee: y_target = y_bound.x 
		if abs(global_position.y - y_bound.x) <= lee: y_target = y_bound.y
	global_position = actual_pos
