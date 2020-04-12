extends AnimatedSprite
export var num = 0
var pnum = 0

func _ready():
	visible = false

func _process(delta): #refactor this to handle inputs neater
	var n = "p" + str(num+1) + "_"
	if Input.is_action_just_pressed(n+"skill"): visible = true
	if Input.is_action_just_pressed(n+"fire"): visible = false
	if Input.is_action_just_pressed(n+"left") and visible: pEdit(-1)
	if Input.is_action_just_pressed(n+"right") and visible: pEdit(1)

func pEdit(direction):
	position -= Global.yOffset[pnum]
	pnum = Global.wrap(pnum, Global.chars, direction)
	set_sprite_frames(load(Global.charSprites[pnum]) )
	var x = Global.charSizeRatio[pnum]*2
	scale = Vector2(x,x)
	if (num+1) % 2 == 0: scale.x = -x  #even number players face other way
	position += Global.yOffset[pnum]
