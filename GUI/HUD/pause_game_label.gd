extends Label

func _ready():
	visible = false
	blink()
	
func _input(event):
	if event.is_action_pressed("pause"):
		GlobalAudio.play_sfx_pause()
		get_tree().paused = !get_tree().paused
		visible = get_tree().paused

func blink() -> void:
	while true:
		if get_tree().paused:
			visible = true # Visible for 1 second
		await get_tree().create_timer(1.0).timeout
		
		if get_tree().paused:
			visible = false  # Invisible for 0.5 seconds		
		await get_tree().create_timer(0.5).timeout
