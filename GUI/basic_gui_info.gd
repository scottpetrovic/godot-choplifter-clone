extends Label


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	text = "A:" + str(Constants.level_total_remaining_prisoners)
	text += "  B:" + str(Constants.player_reference.prisoners_in_helicopter)
	text += "  C:" + str(Constants.level_total_prisoners_saved)
