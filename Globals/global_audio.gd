extends AudioStreamPlayer2D

@onready var sfx_channel_1: AudioStreamPlayer2D = $SFXChannel1

func play_sfx_prisoner_pickup() -> void:
	sfx_channel_1.stop()
	sfx_channel_1.stream = load("res://Audio/prisoner-pickup.wav")
	sfx_channel_1.play()
	
func play_sfx_explosion() -> void:
	sfx_channel_1.stop()
	sfx_channel_1.stream = load("res://Audio/explosion.wav")
	sfx_channel_1.play()


func play_title_music() -> void:
	stop()
	stream = load("res://Audio/Title Battleground Echoes.mp3")
	play()

func play_environment_1_music() -> void:
	stop()
	stream = load("res://Audio/Level 1 - Commander's Anthem ext v1.mp3")
	play()
