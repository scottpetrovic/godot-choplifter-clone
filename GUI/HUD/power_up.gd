extends Label



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	
	if Constants.level_active_powerup == Constants.PowerUpType.BOMBS:
		text = "BOMB"
	elif Constants.level_active_powerup == Constants.PowerUpType.ROPE:
		text = "ROPE"
	else:
		text = ""
