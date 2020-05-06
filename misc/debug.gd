extends Node2D
var heldR = 0
func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
		
	if Input.is_action_just_pressed("d_reset"):
		get_tree().reload_current_scene()
		print("----------------------------")
	if Input.is_action_pressed("d_reset"):
		heldR += 1
		if heldR > 60:
			heldR = 0
			get_tree().change_scene("res://testStages/henryTestSelect.tscn")
	else: heldR = 0
