extends Node2D
export var pnum = 1
export var type = 0 
onready var itemName = name
signal picked_up
var equipped = false
var player
onready var s = "p" + str(pnum) + "_"
onready var hoverTween = $Tween
var oPos

func _ready():
	$equipRadius.set_collision_layer(32)
	$equipRadius.set_collision_mask(32)
	self.connect("picked_up", self, "_on_picked_up")
	hover()

func _physics_process(_delta):  # needs to be physics process cuz order
	$sprite.material = null
	if equipped: 
		position = lerp(position, player.Weapons.posList[itemName], 0.3)

func activate(p):  # is within range to be picked up by a player
	if not equipped:
		$sprite.material = load("res://assets/Shaders/Outline.tres")
		if Input.is_action_just_pressed("p" + str(p.localNum) + "_equip"):
			_on_picked_up(p)

func _on_picked_up(p):
	player = p
	equipped = true
	pnum = p.localNum
	var x = global_position
	$sprite.material = null
	get_parent().remove_child(self)
	p.Weapons.swap(self)
	global_position = x
	hover()

func _on_dropped():
	visible = true
	equipped = false
	hover()
	
func hover():
	hoverTween.remove_all()
	oPos = $sprite.position
	hoverTween.repeat = true  # make the weapon hover 
	var r = randi()%7 + 5
	if equipped: r = 4
	hoverTween.interpolate_property($sprite, "position:y", oPos.y + r, oPos.y - r,
		1, Tween.TRANS_SINE, 2)
	hoverTween.interpolate_property($sprite, "position:y", oPos.y - r, oPos.y + r,
		1, Tween.TRANS_SINE, 2, 1)
	hoverTween.start()
