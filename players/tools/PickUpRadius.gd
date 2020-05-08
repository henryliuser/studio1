extends Area2D
var inRange = {}
onready var player = get_parent().get_node("../player")

func _process(_delta):
	var lowestDist = 99999
	var closestPickup
	for z in inRange.keys():  # pick the closest weapon in range to display
		var x = z.position - player.position
		var dist = sqrt(x.x*x.x + x.y*x.y)
		if dist < lowestDist: 
			closestPickup = z
			lowestDist = dist
		else: closestPickup.equipped = false
	if lowestDist != 99999:
		closestPickup.activate(player)
		
	

func _on_PickUpRadius_area_entered(area):
	var equippable = area.get_parent()
	if !equippable.equipped:
		inRange[equippable] = true
	
func _on_PickUpRadius_area_exited(area):
	inRange.erase(area.get_parent())
