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
	calcSquish()
	calcChainHits()
	
var chainFrames = -1
var damaga = 0  # this is to see if two player_hurt calls happen simultaneously

func getHurt(dmg, stun:int=10, kb:Vector2=Vector2(), pos:Vector2=Vector2() ):
	if dmg > 0:
		modTimer.x = 1  
		modulate = Color.red  # set up red modulation flash
	hp -= dmg
	if hp <= 0: die()
	damaga += dmg
	chainFrames = 2
	yield(get_tree().create_timer(1.0/12), "timeout")
	modulate = omod
#	print(str(dmg) + " " + str(damaga) + " " + str(hp) + " " +str(Global.frameCount))

func showText():
	var txt = load("res://players/tools/DamageText.tscn").instance()
	txt.set_text(str(damaga))
	txt.global_position = global_position + Vector2(0, -75)
	get_tree().current_scene.add_child(txt)

func die():
	queue_free()
	
var counter = 0
func calcSquish():
	var squished = is_on_ceiling() and velocity == Vector2()
	if squished and hp > 0:
		scale.y -= 0.05
		getHurt(1)
		if hp <= 0: 
			showText()
			queue_free()
	if not squished and hp > 0: scale.y = og_scale.y

func calcChainHits():
	if chainFrames > 0: chainFrames -= 1
	if chainFrames == 0:
		showText()
		damaga = 0
		chainFrames = -1


