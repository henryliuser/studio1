extends Node
var numPlayers = 0

var players = []

func addPlayer(id, localNum, charNum):
	numPlayers += 1
	var temp = load(Global.chars[charNum]).instance()
	temp.set_network_master(id)
	temp.set_name(str(localNum) + "-" + str(id) )
	temp.globalNum = numPlayers
	temp.localNum = localNum
	players.push_back(temp)

func editPlayer():
	pass


