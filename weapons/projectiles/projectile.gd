extends Area2D
var keeper
export var independent = true
export var damage = 10
export var duration = 1
export var velocity = Vector2()
export var knockback = Vector2(10,10)
export var stun = 15
export var self_hurt = true
var player

func _physics_process(_delta):
	position += velocity
	duration -= 1
	if duration == 0:
		queue_free()

func _on_projectile_body_entered(body):
	if body.has_method("getHurt"):
		if !self_hurt and body == player: return
		var pos = global_position
		if !independent: pos = player.global_position
		body.getHurt(damage, stun, knockback, pos)
	

