extends Node2D
var pnum = 1
export var type = 0 
export var itemName = ""
signal picked_up
var equipped = false
var player
var s
onready var sprite = $sprite
onready var hoverTween = $Tween
onready var spriteInitPos = $sprite.position

func _ready():
	$equipRadius.set_collision_layer(32)
	$equipRadius.set_collision_mask(32)
	sprite.material = load("res://assets/Shaders/Outline.tres").duplicate()
	sprite.material.set_shader_param("width", 0.0)
	
	self.connect("picked_up", self, "_on_picked_up")
	hover()

func _physics_process(_delta):  # needs to be physics process cuz order
	if equipped: 
		position = lerp(position, player.Weapons.posList[itemName], 0.3)
	sprite.material.set_shader_param("width", 0.0)
	if name == "boomerangSniper":
		print(sprite.material.get_shader_param("width"))
		

func activate(p):  # is within range to be picked up by a player
	if not equipped:
		print(name)
		sprite.material.set_shader_param("width", 1.5)
		if Input.is_action_just_pressed("p" + str(p.localNum) + "_equip"):
			_on_picked_up(p)

func _on_picked_up(p):
#	$sprite.position.y = 0  # this works for guns.. idk gotta investigate more
	player = p
	equipped = true
	pnum = p.localNum
	s = "p" + str(pnum) + "_"
	var x = global_position
#	sprite.material.set_shader_param("width", 0)
	get_parent().remove_child(self)
	p.Weapons.swap(self)
	global_position = x
	hover()

func _on_dropped():
	visible = true
	equipped = false
	sprite.position = spriteInitPos
	hover()
	
func hover():
	hoverTween.remove_all()
	var oPos = spriteInitPos
	hoverTween.repeat = true  # make the weapon hover 
	var r = randi()%7 + 5 if !equipped else 4
	var duration = randf()+0.5 if !equipped else 0.8
	hoverTween.interpolate_property(sprite, "position:y", oPos.y + r, oPos.y - r,
		duration, Tween.TRANS_SINE, 2)
	hoverTween.interpolate_property(sprite, "position:y", oPos.y - r, oPos.y + r,
		duration, Tween.TRANS_SINE, 2, duration)
	hoverTween.start()
