extends Area2D
export var independent = true
export var damage = 10
export var duration = 1
export var velocity = Vector2()
export var knockback = Vector2(10,10)
export var stun = 15
var player

func _ready():
	if !independent: 
		player = get_parent().get_parent().get_parent().get_node("../player")

func _physics_process(delta):
	position += velocity
	duration -= 1
	if duration == 0:
		queue_free()

func _on_projectile_body_entered(body):
	var pos = global_position
	if !independent: pos = player.global_position
	body.getHurt(damage, stun, knockback, pos)

