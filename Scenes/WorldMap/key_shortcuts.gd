extends Node

const WIN_ACTION = "test_win"  # Suggested binding: W key
const LOSE_ACTION = "test_lose" # Suggested binding: L key

func _process(_delta: float) -> void:

	# bypass world map moving and go to next screen
	if Input.is_action_just_pressed(WIN_ACTION):
		Constants.reset_existing_level(false) 
		
