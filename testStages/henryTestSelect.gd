extends Node2D

func _on_boomer_pressed():
	get_tree().change_scene("res://testStages/hennyTest1a.tscn")

func _on_potassiumCannon_pressed():
	get_tree().change_scene("res://testStages/hennyTest1b.tscn")

func _on_tembo_pressed():
	get_tree().change_scene("res://testStages/hennyTest1c.tscn")
	
