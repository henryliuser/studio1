extends "res://players/tools/Char.gd"

var acc
var jetSpeed = 65
var fuel = 100
var maxFuel = 100
var fuelbar

onready var jetflame = $jetflame
onready var flamePos = jetflame.position

func _ready(): 
	acceleration = 80
	jetflame.playing = true
	fuelbar = get_node("../Gauges/FuelBar")

func _on_physics_process(delta):
	._on_physics_process(delta)
	calcJet()

puppet func syncJet(d):
	jetflame.visible = d

func jet():
	sprite.rotation_degrees = lerp(sprite.rotation_degrees, currentDirection * 5, 0.1)
	jetflame.visible = true
#	rpc_unreliable("syncJet", true) #clean this shit
	if velocity.y <= 0: velocity.y -= jetSpeed
	else: velocity.y -= jetSpeed * 1.5
		
#	if velocity.y < 0: velocity.y = max(velocity.y, -500)
	updateFuel(-1.3)

	
puppet func syncFuel(d):
	fuelbar.updateBar(d)
	
func updateFuel(x):
	fuel += x
	fuel = clamp(fuel, 0, 100)
	fuelbar.updateBar(fuel)
#	rpc_unreliable("syncFuel", fuel)

func calcJet():
	jetflame.visible = false
#	rpc_unreliable("syncJet", false)
	if is_on_floor():
		updateFuel(2)
		if fuel >= 30 and holdSkill:
			jet()
		
	elif holdSkill and fuel > 0:
		jet()

func die():
	.die()
	if dead: return
#	jetpack hitbox
	jetflame.visible = false
	$jetpack.queue_free()
#	rpc_unreliable("syncJet", false)

#func _on_jetpack_area_entered(_area):
#	updateFuel(-50)

func getHurt(dmg,stun=10,kb=Vector2(),pos=Vector2()):
	.getHurt(dmg,stun,kb,pos)
	jetflame.visible = false
	
#	area.queue_free()

#func _on_shoot():
#	rotation_degrees -= currentDirection * 20
func restore():
	sprite.modulate.a = lerp(sprite.modulate.a, 1, 0.05)
	hurtbox.scale.y = lerp(hurtbox.scale.y, 1, 0.2)
	rotation_degrees = lerp(rotation_degrees, 0, 0.2)
	if unactionable.x == 0 and !jetflame.visible: sprite.rotation_degrees = lerp(sprite.rotation_degrees, 0, 0.2)
