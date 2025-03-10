extends Control


func _ready() -> void:
	
	# going to main menu effectively is a game over	
	# if we beat the game and return to the main
	# menu, we don't want the current level to be at the end	
	Constants.initialize_game_level_data()
	
	GlobalAudio.play_title_music()

func _process(_delta: float) -> void:

	if Input.is_action_just_pressed("shoot"):
		Constants.go_to_next_level()
		#Constants.go_to_instructions_screen()
