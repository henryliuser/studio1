extends Node
var numPlayers = 0
#class Player:
#	var machineID
#	var localNum
#	var globalNum
#	var character = "res://players/"
#	func _init(machineId,localNum,globalNum,character):
#		self.machineId = machineId
#		self.localNum = localNum
#		self.globalNum = globalNum
#		self.character = character

var players = []
var machines = []

func addPlayer(id, localNum, chara):
	machines.push_back(id)
	numPlayers += 1
	var temp = load(chara).instance()
	temp.globalNum = numPlayers
	temp.localNum = localNum
	players.push_back(temp)
	

func editPlayer():
	pass
#	machines[id] = Player.new(id,num,numPlayers,chara)

