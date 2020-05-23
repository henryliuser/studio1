extends "res://Being.gd"
export var health = 25
export var velo = Vector2(200, 0)
func _ready():
	hp = health
	velocity = velo
	chainFrames = 4

func _physics_process(delta):
	velocity.y += 30 
	if $left.is_colliding() or $right.is_colliding(): velocity.x *= -1
	velocity = move_and_slide(velocity, Vector2.UP)
	
func getHurt(dmg, stun:int=10, kb:Vector2=Vector2(), pos:Vector2=Vector2() ):
	.getHurt(dmg,stun,kb,pos)
	print(Global.frameCount)
