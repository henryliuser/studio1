extends Node2D
onready var locals = $locals

func _ready():
	get_tree().connect("network_peer_connected", self, "_player_connected")

func _player_connected(id):
	print("Player connected to server!")
	for x in locals:
		pass #START HERE
	var game = preload("res://testStages/hennyTest2.tscn").instance()
#	get_tree().change_scene("res://testStages/hennyTest2.tscn")
	get_tree().get_root().add_child(game)
	hide()

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
