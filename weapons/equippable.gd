extends Node2D
var pnum = 1
export var type = 0 
onready var itemName = name
signal picked_up
var equipped = false
var player
var s
var highlighted = false
onready var sprite = $sprite
onready var hoverTween = $Tween
onready var spriteInitPos = $sprite.position

func _ready():
	$equipRadius.set_collision_layer(32)
	$equipRadius.set_collision_mask(32)
	self.connect("picked_up", self, "_on_picked_up")
	hover()

func _physics_process(_delta):  # needs to be physics process cuz order
	highlighted = false
	if equipped: 
		position = lerp(position, player.Weapons.posList[itemName], 0.3)

func activate(p):  # is within range to be picked up by a player
	highlighted = true
	if not equipped:
		if sprite.material == null:
			sprite.material = load("res://assets/Shaders/Outline.tres")
		if Input.is_action_just_pressed("p" + str(p.localNum) + "_equip"):
			_on_picked_up(p)

func _on_picked_up(p):
#	$sprite.position.y = 0  # this works for guns.. idk gotta investigate more
	player = p
	equipped = true
	pnum = p.localNum
	s = "p" + str(pnum) + "_"
	var x = global_position
	$sprite.material = null
	get_parent().remove_child(self)
	p.Weapons.swap(self)
	global_position = x
	hover()

func _on_dropped():
	visible = true
	equipped = false
	$sprite.position = spriteInitPos
	hover()
	
func hover():
	hoverTween.remove_all()
	var oPos = spriteInitPos
	hoverTween.repeat = true  # make the weapon hover 
	var r = randi()%7 + 5 if !equipped else 4
	var duration = randf()+0.5 if !equipped else 0.8
	hoverTween.interpolate_property($sprite, "position:y", oPos.y + r, oPos.y - r,
		duration, Tween.TRANS_SINE, 2)
	hoverTween.interpolate_property($sprite, "position:y", oPos.y - r, oPos.y + r,
		duration, Tween.TRANS_SINE, 2, duration)
	hoverTween.start()
