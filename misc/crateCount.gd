extends Label
var crates = 0
	
func crate():
	crates += 1
	text = str(crates)
