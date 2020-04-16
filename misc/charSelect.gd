extends AnimatedSprite
export var localNum = 1
var charNum = 0
var id = 0

func _ready():
	visible = false
	id = get_tree().get_network_unique_id()

func _process(_delta): #refactor this to handle inputs neater
	var n = "p" + str(localNum) + "_"
	if Input.is_action_just_pressed(n+"skill"): visible = true
	if Input.is_action_just_pressed(n+"fire"): visible = false
	if Input.is_action_just_pressed(n+"left") and visible: pEdit(-1)
	if Input.is_action_just_pressed(n+"right") and visible: pEdit(1)

func pEdit(direction):
	position -= Global.yOffset[charNum]
	charNum = Global.wrap(charNum, Global.chars, direction)
	set_sprite_frames(load(Global.charSprites[charNum]) )
	var x = Global.charSizeRatio[charNum]*2
	scale = Vector2(x,x)
	if (localNum) % 2 == 0: 
		scale.x = -x  #even number players face other way
	position += Global.yOffset[charNum]

func pushGlobal():
	ENetGlobal.addPlayer(id, localNum, charNum)
