extends Control


func _ready() -> void:
	GlobalAudio.play_title_music()

func _process(_delta: float) -> void:

	if Input.is_action_just_pressed("shoot"):
		Constants.go_to_next_level()
		#Constants.go_to_instructions_screen()
