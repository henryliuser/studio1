extends Node

var frameCount = 0
var timeCount = 0

func _process(delta):
	frameCount += 1
	timeCount += delta

var chars = ["res://players/walker.tscn",
			 "res://players/shade.tscn"]

var charSprites = ["res://players/tools/walkerSprite.tres",
				   "res://players/tools/shadeSprite.tres"]

var charSizeRatio = [5, 4]

var yOffset = [Vector2(0,0),
			   Vector2(0,-50)]

var weapon_names = ["res://weapons/Tembo.tscn",
					"res://weapons/boomerangSniper.tscn",
					"res://weapons/meterstick.tscn",
					"res://weapons/potassiumCannon.tscn",
					"res://weapons/toxicRifle.tscn"]

func wrap(curr,theArray,direction):
	curr += direction 
	if curr < 0:
		curr = theArray.size()-1
	elif curr >= theArray.size():
		curr = 0
	return curr

func _ready():
	randomize()

func attach(object, target):
	var stuff = [object.global_position, object.global_rotation, object.global_scale, object.modulate]
	object.get_parent().remove_child(object)
	target.add_child(object)
	object.global_position = stuff[0]; object.global_rotation = stuff[1]
	object.global_scale = stuff[2]; object.self_modulate = stuff[3]

func inter_prop(obj, path, init, final, dur, t=0, e=2, delay=0):
	var tw = Tween.new()
	get_tree().get_root().add_child(tw)
	tw.interpolate_property(obj,path,init,final,dur,t,e,delay)
	tw.start()
	yield(get_tree().create_timer(delay+dur, false), "timeout")
	tw.queue_free()
