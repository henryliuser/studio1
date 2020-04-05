extends Node2D

func _ready():
#	get_tree().connect("network_peer_connected", self, "_player_connected")
	pass

func _on_buttServer_pressed():
#	get_tree().change_scene("res://networking/ENetServer.tscn")
	print("Hosting network")
	var host = NetworkedMultiplayerENet.new()
	var res = host.create_server(6969,2)
	host.connect("peer_connected",self,"_player_connected")
	if res != OK:
		print("Error creating server")
		return
	$buttClient.hide()
	$buttServer.disabled = true

func _on_buttClient_pressed():
#	get_tree().change_scene("res://networking/ENetClient.tscn")
	print("Joining network")
	var host = NetworkedMultiplayerENet.new()
	host.create_client("127.0.0.1", 6969)
	get_tree().set_network_peer(host)
	$buttServer.hide()
	$buttClient.disabled = true

func _player_connected(id):
	print ("Player " + str(id) + " joined the game.")
	ENetGlobal.otherPlayers.push_back(id)
	var game = preload("res://testStages/hennyTest2.tscn").instance()
	get_tree().get_root().add_child(game)
	hide()
