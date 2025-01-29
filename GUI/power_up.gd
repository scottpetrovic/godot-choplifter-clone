extends Label



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if Constants.level_active_powerup == Constants.PowerUpType.BOMBS:
		text = "BOMB"
	else:
		text = ""
