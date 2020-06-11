extends Area2D
export var knockback = 1000
onready var tween = $Tween

func _on_Bumper_body_entered(body):
	if body.has_method("getHurt"):
		set_deferred("monitoring", false) 
		var dif = body.global_position - global_position
		var mag = sqrt(dif.x*dif.x + dif.y*dif.y)
		var unitvec = dif/mag
		unitvec.x = abs(unitvec.x)
		if body.has_method("jet"): body.updateFuel(20)
		body.getHurt(0, 15, unitvec * knockback, global_position)
		scale = Vector2(1.5,1.5)
		tween.interpolate_property(self, "scale", scale, Vector2(1,1),0.5)
		tween.start()
		$sprite.frame = 0
		yield(get_tree().create_timer(0.5, false), "timeout")
		monitoring = true
	
