extends Node2D
export var playerNum = 1
onready var p = $player
func _ready():
	if playerNum == 2:  # turn them around if they're player 2
		p.playerNum = playerNum
		p.currentDirection = -1
		p.storedDirection = -1
		p.sprite.flip_h = true
		p.hitbox.scale.x = -1
#		p.sprite.modulate = Color.peru
