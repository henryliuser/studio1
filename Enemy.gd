extends "res://Being.gd"
export var health = 20
export var velo = Vector2(200, 0)
func _ready():
	hp = health
	velocity = velo

func _physics_process(delta):
	velocity.y += 30 
	if $left.is_colliding() or $right.is_colliding(): velocity.x *= -1
	velocity = move_and_slide(velocity, Vector2.UP)
	if hp<= 0: rotation_degrees += 300*delta
	
func getHurt(dmg, stun:int=10, kb:Vector2=Vector2(), pos:Vector2=Vector2() ):
	.getHurt(dmg,stun,kb,pos)
	chainFrames = 6

func _on_hitbox_body_entered(body):
	if body == self: return
	if body.has_method("die"): 
		body.showText(100)
		body.die()

func die():
	if dead: return
	dead = true
	set_collision_layer(0)
	set_collision_mask(0)
	$hitbox.queue_free()
	velocity.y = -1500
	scale /= 1.2
	$left.enabled = false
	$right.enabled = false
	
	yield(get_tree().create_timer(5, false), "timeout")
	queue_free()
	
