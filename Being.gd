extends KinematicBody2D

#animation
var currentDirection = 1
onready var sprite = $sprite
onready var hurtbox = $hurtbox
onready var omod = modulate
onready var og_scale = scale

var velocity = Vector2()
var modTimer = Vector2(0,5)
var hp = 100

func _physics_process(delta):
	pass
func getHurt(dmg, stun:int=10, kb:Vector2=Vector2(), pos:Vector2=Vector2() ):
	if dmg > 0:
		modTimer.x = 1  
		modulate = Color.red  # set up red modulation flash
	hp -= dmg
	if hp <= 0: die()
	yield(get_tree().create_timer(1.0/12), "timeout")
	modulate = omod

func die():
	queue_free()
func squish():
	queue_free()




