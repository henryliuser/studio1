extends Node2D
var heldR = 0
func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
		
	if Input.is_action_just_pressed("d_reset"):
		clear()
		yield(get_tree().create_timer(delta/2), "timeout")  # One of the weirdest engine bugs ever
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
	if Input.is_action_just_pressed("debug_pause"):
		get_tree().paused = false if get_tree().paused else true
	if get_tree().paused and Input.is_action_just_pressed("debug_frame_advance"):
		get_tree().paused = false
		yield(get_tree().create_timer(delta),"timeout")
		get_tree().paused = true

func clear():
	for x in get_tree().current_scene.get_children():
		x.queue_free()

