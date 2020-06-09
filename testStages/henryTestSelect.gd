extends Node2D

func _on_boomer_pressed():
	get_tree().change_scene("res://testStages/hennyTest1c.tscn")

func _on_random2_pressed():
	get_tree().change_scene("res://testStages/hennyTest2a.tscn")

func _on_boomer2_pressed():
	get_tree().change_scene("res://testStages/hennyTest1a.tscn")

func _on_bug_pressed():
	get_tree().change_scene("res://testStages/hennyTest1BUG.tscn")

func _on_enemyTest_pressed():
	get_tree().change_scene("res://testStages/hennyTest1b.tscn")
	
func _on_bug2_pressed():
	get_tree().change_scene("res://testStages/exportTest.tscn")
	
func _on_random3_pressed():
	get_tree().change_scene("res://testStages/hennyTest2b.tscn")
