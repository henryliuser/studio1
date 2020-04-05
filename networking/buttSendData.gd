extends Button
onready var line = $LineEdit
func _on_buttSendData_pressed():
	print("Sending data to client")
	var text = line.text
	get_tree().multiplayer.send_bytes(text.to_ascii())
