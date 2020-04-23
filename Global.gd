extends Node

var chars = ["res://players/walker.tscn",
			 "res://players/shade.tscn"]

var charSprites = ["res://players/tools/walkerSprite.tres",
				   "res://players/tools/shadeSprite.tres"]

var charSizeRatio = [5, 4]

var yOffset = [Vector2(0,0),
			   Vector2(0,-50)]

func wrap(curr,theArray,direction):
	curr += direction 
	if curr < 0:
		curr = theArray.size()-1
	elif curr >= theArray.size():
		curr = 0
	return curr