extends "res://players/tools/HPBar.gd"

func updateBar(f):
	t.value = f
	if p.value-t.value <= 1:
		p.value = t.value

func _process(delta):
	if tweening:
		if p.value < t.value: p.value = t.value
		p.value = lerp(p.value, t.value, lerpWeight)
		var diff = p.value-t.value
		if abs(diff) <= 1:
			p.value = t.value
