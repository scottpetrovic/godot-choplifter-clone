extends Node

const WIN_ACTION = "test_win"  # Suggested binding: W key
const LOSE_ACTION = "test_lose" # Suggested binding: L key

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed(WIN_ACTION):
		trigger_win()
	
	if Input.is_action_just_pressed(LOSE_ACTION):
		trigger_lose()
		

func trigger_win() -> void:
	EventBus.LevelComplete.emit()


func trigger_lose() -> void:
	EventBus.LevelFailed.emit()
