extends Node2D
var heldR = 0
func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
		
	if Input.is_action_just_pressed("d_reset"):
		clear()
		get_tree().reload_current_scene()
		print("----------------------------")
	if Input.is_action_pressed("d_reset"):
		heldR += 1
		if heldR > 60:
			heldR = 0
			clear()
			get_tree().change_scene("res://testStages/henryTestSelect.tscn")
	else: heldR = 0
	if Input.is_action_just_pressed("debug_menu"):
		get_tree().change_scene("res://testStages/henryTestSelect.tscn")

func clear():
	for x in get_tree().current_scene.get_children():
		x.queue_free()
