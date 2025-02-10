extends Button

var is_sfx_on: bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pressed.connect(_toggle_sfx)

func _toggle_sfx() -> void:
	if is_sfx_on:
		is_sfx_on = false
		GlobalAudio.set_sfx_volume(-100.0)
		text = "SOUND EFFECTS OFF"
	else:
		is_sfx_on = true
		GlobalAudio.set_sfx_volume(0.0)
		text = "SOUND EFFECTS ON"
