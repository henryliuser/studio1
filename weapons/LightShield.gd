extends "res://weapons/melee.gd"
onready var player_tween = $PlayerTween
var og_key_values = []

func _ready():
	for x in range(5):
		og_key_values.append(anim.get_animation("hit").track_get_key_value(0,x))

func hit():
	.hit()
	var qqq = []
	for x in range(5):
		anim.get_animation("hit").track_set_key_value(0, x, position+og_key_values[x])
	var target1_deg = player.currentDirection * 10
	var target2_deg = player.currentDirection * -25
	
	player_tween.interpolate_property(player.sprite,"rotation_degrees", player.rotation_degrees,
		target2_deg, 0.25, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	player_tween.interpolate_property(player.sprite,"rotation_degrees", player.rotation_degrees,
		target1_deg, 0.2, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	player_tween.interpolate_property(player.sprite,"rotation_degrees", target1_deg, 
		target2_deg, 0.05, Tween.TRANS_CUBIC, Tween.EASE_OUT, 0.2)
	player_tween.interpolate_property(player.sprite,"rotation_degrees", target2_deg,
		player.rotation_degrees, 0.75, Tween.TRANS_CUBIC, Tween.EASE_OUT, 0.25)
	player_tween.start()

func _physics_process(delta):
	rotation_degrees = lerp(rotation_degrees, 0, 0.1)
	var bounce_pos
	if equipped: 
		bounce_pos = player.Weapons.posList[itemName] + Vector2(player.currentDirection*-5,70)
		var down = Input.is_action_pressed(s + "down")
		if !anim.is_playing():
			down = Input.is_action_pressed(s+"down")
		if visible and down:
			hoverTween.stop_all()  # DOESN'T WORK
			var pRot = player.sprite.rotation_degrees
			var pDirec = player.currentDirection
			if !anim.is_playing():
				if player.is_on_floor():
					player.sprite.rotation_degrees = lerp(pRot, -pDirec*50, 0.1)
					rotation_degrees = lerp(rotation_degrees, -scale.x * 50, 0.1)
				else:
					player.sprite.rotation_degrees = lerp(pRot, -pDirec*-150, 0.1)
					rotation_degrees = lerp(rotation_degrees, -scale.x * -130, 0.2)
					position = lerp(position, bounce_pos, 0.1)
		if Input.is_action_just_released(s+"down"): hoverTween.resume_all()
	
func _on_physics_process():
	if equipped and visible and $passiveBlockArea.monitoring: player.shielded = true 
	elif equipped: player.shielded = false
	if !visible: player.shielded = false
	if equipped and (!Input.is_action_pressed(s+"down") or player.is_on_floor()): 
		position = lerp(position, player.Weapons.posList[itemName], 0.3)
	sprite.material.set_shader_param("width", 0.0)
	
func _on_bounceCheck_body_entered(body):  # BOUNCE
	var check = equipped and !anim.is_playing() and !player.is_on_floor()
	if check and Input.is_action_pressed(s+"down") and body != player:
		if body.has_method("getHurt"): 
			body.scale.y -= 0.5
			body.getHurt(15, 20) 
		player.scale.y += 0.5
		player.velocity.y = -900
#		player.velocity.y *= -1
#		player.velocity.x += player.currentDirection * 200

func _on_dropped():
	player.shielded = false
	._on_dropped()
