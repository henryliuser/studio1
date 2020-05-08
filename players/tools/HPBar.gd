extends Node2D
onready var t = $texture
onready var p = $polish
onready var tween = $Tween
export var tweening = true
export var lerpWeight = 0.4
export var is_for_hp = true

var damaga = 0 # this is to see if two player_hurt calls happen simultaneously

var player
func _ready():
	t.value = 100
	p.value = 100
	var x = get_parent().get_node("../player")
	x.connect("hurt", self, "_on_player_hurt")
	
func die():
	updateBar(0)

var chainFrames = -1
func _process(_delta):
	if chainFrames > 0: chainFrames -= 1
	if chainFrames == 0 and is_for_hp:
		showText()
		damaga = 0
		chainFrames = -1
	
func updateBar(value):
	if tweening:
		tween.interpolate_property(p, "value", t.value, value, lerpWeight)
		tween.start()
	t.value = value

func _on_player_hurt(_player, dmg):
	damaga += dmg
	chainFrames = 2

func showText():
	var txt = load("res://players/tools/DamageText.tscn").instance()
	txt.set_text(str(damaga))
	txt.global_position = global_position
	get_tree().current_scene.add_child(txt)
