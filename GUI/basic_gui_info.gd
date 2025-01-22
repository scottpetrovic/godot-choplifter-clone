extends Label


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	text = "Remaining: " + str(Constants.level_total_remaining_prisoners) + '\n'
	text += "In Copter: " + str(Constants.player_reference.prisoners_in_helicopter)
