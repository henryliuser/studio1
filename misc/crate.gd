extends Sprite
signal crate
var x
func _ready(): 
	connect("crate", get_node("../crateCount"), "crate")
	randomize()
	x = load(Global.weapon_names[randi()%len(Global.weapon_names)]).instance()
	x.visible = false
	get_tree().current_scene.add_child(x)
	
func _on_Area2D_body_entered(body):
	emit_signal("crate")
	body.Weapons.delete(body.Weapons.active)
	x.global_position = global_position
	x.call_deferred("_on_picked_up", body)
	call_deferred("deferral")
	queue_free()
	
func deferral():
	var next_crate = self.duplicate()
	next_crate.position = Vector2(randi()%1500+210, randi()%600+240)
	get_tree().current_scene.add_child(next_crate)
	
	
