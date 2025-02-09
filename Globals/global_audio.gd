extends AudioStreamPlayer2D
@onready var sfx_channel_1: AudioStreamPlayer2D = $SFXChannel1

const FADE_DURATION := 1.0
const FADE_DB_MIN := -80.0
const FADE_DB_MAX := 0.0  # Or whatever your default volume should be

func _fade_audio(target_db: float, duration: float, on_complete: Callable = Callable()) -> void:
	var tween = create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(self, "volume_db", target_db, duration)
	if not on_complete.is_null():
		tween.tween_callback(on_complete)

func _on_fade_out_complete(new_music_path: String) -> void:
	stop()
	stream = load(new_music_path)
	volume_db = FADE_DB_MIN  # Start from silent
	play()	
	_fade_audio(FADE_DB_MAX, FADE_DURATION) # Fade in the new music

func _switch_music(new_music_path: String) -> void:
	# First fade out current music if playing
	if playing:
		var fade_out_complete := func(): _on_fade_out_complete(new_music_path)
		_fade_audio(FADE_DB_MIN, FADE_DURATION, fade_out_complete)
	else:
		# If nothing is playing, just start the new music with a fade in
		stream = load(new_music_path)
		volume_db = FADE_DB_MIN
		play()
		_fade_audio(FADE_DB_MAX, FADE_DURATION)

# Your existing SFX functions remain unchanged
func play_sfx_prisoner_pickup() -> void:
	sfx_channel_1.stop()
	sfx_channel_1.stream = load("res://Audio/prisoner-pickup.wav")
	sfx_channel_1.play()
	
func play_sfx_explosion() -> void:
	sfx_channel_1.stop()
	sfx_channel_1.stream = load("res://Audio/explosion.wav")
	sfx_channel_1.play()
	
func play_sfx_door_break() -> void:
	sfx_channel_1.stop()
	sfx_channel_1.stream = load("res://Audio/door-break.wav")
	sfx_channel_1.play()

func play_sfx_pause() -> void:
	sfx_channel_1.stop()
	sfx_channel_1.stream = load("res://Audio/pause.wav")
	sfx_channel_1.play()

func play_title_music() -> void:
	_switch_music("res://Audio/Title Battleground Echoes.mp3")

func play_environment_1_music() -> void:
	_switch_music("res://Audio/Level 1 - Commander's Anthem ext v1.mp3")

func fade_out_music() -> void:
	_fade_audio(FADE_DB_MIN, FADE_DURATION, stop)
