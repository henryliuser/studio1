extends Node2D

export var enabled = true
export var delay = 150
var timer = delay - 1

func _physics_process(delta):
	if enabled: timer += 1
	if timer >= delay:
		timer = 0
		spawn_random()
		
func spawn_random():
#	var scl = Vector2(randf()*2 + 0.3, randf()*2 + 0.3)
	var direction = randi() % 2
	var enemy = load("res://enemies/TestEnemy.tscn").instance()
	enemy.global_position = Vector2(1920/2, -50)
#	enemy.scale = scl
#	enemy.hp = scl.x * 15
	if direction == 0: enemy.velo.x *= -1
	get_node("../enemies").add_child(enemy)
