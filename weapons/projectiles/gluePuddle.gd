extends Area2D

func _ready():
	$Tween.interpolate_property($sprite, "scale:x", $sprite.scale.x, 3.5,
		0.3, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	$Tween.start()

func _on_GluePuddle_body_entered(body):
	if body.has_method("get_slowed"):
		body.get_slowed(2, 0, true)
		
func _on_GluePuddle_body_exited(body):
	if body.has_method("get_slowed"):
		body.get_slowed(0.5)  # undo the existing slow
		body.get_slowed(2, 0.5, true)

func _on_Timer_timeout():  ## in case something breaks when it disappears # nvm
	$Tween.interpolate_property(self, "modulate:a", modulate.a, 0,
		0.5, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	$Tween.start()
	yield(get_tree().create_timer(0.5, false), "timeout")
	queue_free()

