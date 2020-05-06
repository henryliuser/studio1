extends Node2D

func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
		
	if Input.is_action_just_pressed("d_reset"):
		get_tree().reload_current_scene()
		print("----------------------------")
