extends Node2D

export var enabled = true

var count = 0
func _physics_process(delta):
	if enabled: count += 1
	if count >= 150:
		count = 0
		spawn_random()
		
func spawn_random():
#	var scl = Vector2(randf()*2 + 0.3, randf()*2 + 0.3)
	var direction = randi() % 2
	var enemy = load("res://enemies/TestEnemy.tscn").instance()
	enemy.global_position = Vector2(1920/2, -60)
#	enemy.scale = scl
#	enemy.hp = scl.x * 15
	if direction == 0: enemy.velo.x *= -1
	get_tree().current_scene.add_child(enemy)
