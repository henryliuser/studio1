extends "res://pickups/Pickup.gd"
export var heal_amount = 20

func _on_HealthPack_body_entered(body):
	if body.has_method("heal"):
		if body.hp != 100:
			body.heal(20)
			queue_free()
