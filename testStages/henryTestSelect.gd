extends Node2D

func _on_boomer_pressed():
	get_tree().change_scene("res://testStages/hennyTest1.tscn")
	
func _on_random_pressed():
	get_tree().change_scene("res://testStages/hennyTest2.tscn")

func _on_random2_pressed():
	get_tree().change_scene("res://testStages/hennyTest2a.tscn")
