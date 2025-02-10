extends Control

func _ready():
	visible = false
	
func _input(event):
	if event.is_action_pressed("pause"):
		GlobalAudio.play_sfx_pause()
		get_tree().paused = !get_tree().paused
		visible = get_tree().paused
