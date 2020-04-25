extends Node2D
export var globalNum = 1
export var localNum = 1
export var netID = 0
onready var p = $player

func _ready():
	p.netID = netID
	if globalNum % 2 == 0: #turn them around if they're globally player 2/4
		p.currentDirection = -1
		p.storedDirection = -1
		p.sprite.flip_h = true
		p.hurtbox.scale.x = -1
	if localNum == 2:  # set p2 controls if they're loccally player 2
		p.localNum = localNum
