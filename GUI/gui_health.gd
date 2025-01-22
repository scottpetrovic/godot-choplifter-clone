extends Label

func _process(delta: float) -> void:
	text = 'Health:' + str(Constants.player_reference.health) + '/'
	text += str(Constants.player_reference.max_health)
