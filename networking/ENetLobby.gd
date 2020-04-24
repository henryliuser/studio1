extends Node2D
onready var locals = $locals
var testCount = 0
#put networking on hold
func _ready():
	get_tree().connect("network_peer_connected", self, "_player_connected")

func pushPlayers(localP):  #fix formatting
	for x in localP.get_children():
		if x.visible:
			x.pushGlobal()
func pushNetwork(localP,id):
	for x in localP.get_children():
		if x.visible:
			rpc("pushPlayer", id, x.localNum, x.charNum)

remote func pushPlayer(id, localNum,charNum):
	ENetGlobal.addPlayer(id, localNum, charNum)
#	start()

func _player_connected(id):
	print("Player connected to server!")
	pushPlayers(locals)
	pushNetwork(locals,id)

func _on_buttonHost_pressed():
	print("Hosting network")
#	ENetGlobal.addPlayer(get_tree().get_network_unique_id(), )
	var host = NetworkedMultiplayerENet.new()
	var res = host.create_server(6969,2)
	if res != OK:
		print("Error creating server")
		return

	$buttonJoin.hide()
	$buttonHost.disabled = true
	get_tree().set_network_peer(host)

func _on_buttonJoin_pressed():
	print("Joining network")
	var host = NetworkedMultiplayerENet.new()
	host.create_client("127.0.0.1",6969)
	get_tree().set_network_peer(host)
	$buttonHost.hide()
	$buttonJoin.disabled = true

remote func remote_start():
	start()

func start():
#	var game = preload("res://testStages/hennyTest1b.tscn").instance
#	get_tree().get_root().add_child(game)
	get_tree().change_scene("res://testStages/hennyTest1b.tscn")
	hide()


func _on_buttonHost2_pressed():
	start()
	rpc("remote_start")
