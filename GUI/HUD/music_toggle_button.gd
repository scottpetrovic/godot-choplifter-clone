extends Button

var is_music_on: bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pressed.connect(_toggle_music)

func _toggle_music() -> void:
	if is_music_on:
		is_music_on = false
		GlobalAudio.set_music_volume(-100.0)
		text = "MUSIC OFF"
	else:
		is_music_on = true
		GlobalAudio.set_music_volume(0.0)
		text = "MUSIC ON"
