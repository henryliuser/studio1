extends Node
var numPlayers = 0
var players = {}

func addPlayer(id, num, chara):
	numPlayers += 1
	players[id] = [numPlayers, chara]


#figure this shit out
