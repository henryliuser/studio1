extends Area2D
export var damage = 0
export var stun = 0
export var knockback = Vector2()
var player

func _on_hitbox_body_entered(body):
	if body.has_method("getHurt") and body != player:
		body.getHurt(damage, stun, knockback, player.global_position)
	
