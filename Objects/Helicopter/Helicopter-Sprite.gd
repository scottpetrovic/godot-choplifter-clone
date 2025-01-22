extends Sprite2D


func _update_sprite_rotation(delta: float) -> void:
	var player_x_velocity: float = Constants.player_reference.velocity.x
	var animation_mult = 5 # control animation speed
	var rotation_amount: float = 15
	
	if player_x_velocity > 0:
		rotation_degrees = lerpf(rotation_degrees, rotation_amount, delta*animation_mult)
	elif player_x_velocity < 0:
		rotation_degrees = lerpf(rotation_degrees, -rotation_amount, delta*animation_mult)
	else:
		rotation_degrees = lerpf(rotation_degrees, 0, delta*animation_mult)

func _update_sprite_source() -> void:
	# upate texture depending on what direction player is facing
	if Constants.player_direction == Constants.PlayerFacingDirection.LEFT:
		texture = load("res://Objects/Helicopter/helicopter-facing-left.png")
		flip_h = false
	elif Constants.player_direction == Constants.PlayerFacingDirection.RIGHT:
		texture =  load("res://Objects/Helicopter/helicopter-facing-left.png")
		flip_h = true
	else:
		texture = load("res://Objects/Helicopter/helicopter-facing-down.png")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_update_sprite_rotation(delta)
	_update_sprite_source()
