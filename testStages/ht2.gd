extends Node2D

var slowdown = false
var start_hori = false
var prestage = false
var stage
onready var L = $left_start
onready var R = $right_start

func _ready():
	yield(get_tree().create_timer(13, false), "timeout")  # activate home plats
	L.is_seesaw = true; R.is_seesaw = true
	L.patrol_x = Vector2(-50, 200); R.patrol_x = Vector2(50, -200)
	L._ready(); R._ready()
	yield(get_tree().create_timer(2, false), "timeout")  # slow down
	slowdown = true
	yield(get_tree().create_timer(3, false), "timeout")
	$platSpawnerFR.on = false
	slowdown = false
	start_hori = true
	$hori.on = true
	yield(get_tree().create_timer(2, false), "timeout")
	start_hori = false
	yield(get_tree().create_timer(18, false), "timeout")  # stage
	$hori.on = false
	$hori.timer = $hori.delay - 1
	prestage = true
	stage = load("res://testStages/stageA.tscn").instance()
	stage.position = Vector2(0,1000)
	add_child(stage)
	yield(get_tree().create_timer(10, false), "timeout")
	prestage = false

func _physics_process(delta):
	if slowdown:
		for p in $platSpawnerFR.get_children(): 
			p.velocity = lerp(p.velocity, Vector2(0,0), 0.01)
			p.patrol_y = p.patrol_x/2
			p.patrol_x = Vector2()
	if start_hori:
		for p in $platSpawnerFR.get_children(): 
			p.velocity = lerp(p.velocity, Vector2(300,0), 0.03)
		$left_start.position.y += 120 * delta
		$right_start.position.y += 120 * delta
	if prestage:
		stage.position = lerp(stage.position, Vector2(0,0), 0.01)



#		if is_instance_valid(L): L.position.x = lerp(L.position.x, -500, 0.01)
#		if is_instance_valid(R): R.position.x = lerp(R.position.x, 2420, 0.01)
#		if is_instance_valid(L): L.position.y = lerp(L.position.y, 1500, 0.01)
#		if is_instance_valid(R): R.position.y = lerp(R.position.y, 1500, 0.01)
