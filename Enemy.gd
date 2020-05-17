extends "res://Being.gd"
export var health = 25
export var velo = Vector2(200, 0)
func _ready():
	hp = health
	velocity = velo

func _physics_process(delta):
	velocity.y += 30 
	if $left.is_colliding() or $right.is_colliding(): velocity.x *= -1
	velocity = move_and_slide(velocity)
	
func getHurt(dmg, stun:int=10, kb:Vector2=Vector2(), pos:Vector2=Vector2() ):
	.getHurt(dmg,stun,kb,pos)
	var txt = load("res://players/tools/DamageText.tscn").instance()
	txt.real_scale = Vector2(0.9, 0.9)
	txt.set_text(str(dmg))
	txt.global_position = global_position
	get_tree().current_scene.add_child(txt)
