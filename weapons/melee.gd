extends "res://weapons/equippable.gd"
onready var anim = $AnimationPlayer

var k = 0
func _physics_process(delta):
	var playin = anim.is_playing()
	if not equipped:
		rotation_degrees = lerp(rotation_degrees, 0, 0.2)
	if equipped and not playin:
		if Input.is_action_just_pressed("p" + str(pnum) + "_hit"):
			hit()
			
	
	if playin: 
		hoverTween.stop_all()
		k+=1
		print(k)
	else: hoverTween.resume_all()

func _on_picked_up(p):
	._on_picked_up(p)
	for x in $hitboxes.get_children():
		x.player = player

func _on_dropped():
	._on_dropped()
	var rot = rotation_degrees
	anim.stop()
	rotation_degrees = rot

func hit():
	get_parent().update_active(type)
	anim.play("hit")
	$sprite.position = spriteInitPos
