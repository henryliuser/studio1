extends "res://weapons/projectiles/projectile.gd"
export var lerpWeight = 0.94

var target = Vector2(1000,0)
var ogPos
var dontTouch  # the player/owner, will be set on creation
var time = 0
var speed = 50.0
const guesSpeed = 1.0498
var reached = false

func _ready():
	$sprite.play("start")
	target += global_position

func _physics_process(_delta):
	var final = false  # this is to make sure it actually reaches end
	speed /= guesSpeed
	time += 1
#	rotation_degrees += 200*delta
	var gap = target - global_position
	if speed < 0.5:
		reached = true
		time = 0
	if reached:
		speed *= guesSpeed*guesSpeed
		gap = ogPos - global_position
		if gap.abs() <= Vector2(300,300): $sprite.play("end")
		if gap.abs() <= Vector2(100,100): final = true
		if gap.abs() <= Vector2(20,20): queue_free()
		
	if final:
		global_position = lerp(global_position, ogPos, 0.3)
	else: global_position += unit(gap)*speed

#	if abs(gap.x) < 5: 
#		reached = true
#		time = 0
#	if reached:
#		gap = ogPos - global_position
#		global_position += unit(gap)*pow(2-lerpWeight+0.03, time)
#		if global_position-ogPos <= Vector2(): queue_free()
#	else:
#		global_position = target - gap*pow(lerpWeight, time)
	
func unit(v2):
	return v2 / sqrt(v2.x*v2.x + v2.y*v2.y)


func _on_sprite_animation_finished():
	if $sprite.animation == "start":
		$sprite.play("loop")

func _on_projectile_body_entered(body):
	._on_projectile_body_entered(body)
	if body == dontTouch:
		queue_free()
		
	
