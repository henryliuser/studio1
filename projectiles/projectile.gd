extends Area2D
export var damage = 10
export var duration = 1
export var pos = Vector2()
export var velocity = Vector2()
export var knockback = Vector2(10,10)
export var stun = 15

func _physics_process(delta):
	position += velocity
	duration -= 1
	if duration <= 0:
		queue_free()

func _on_projectile_body_entered(body):
	body.getHurt(damage, stun, knockback, pos)
