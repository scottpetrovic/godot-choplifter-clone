extends Label

func _ready() -> void:
	EventBus.LevelComplete.connect(_level_complete)
	EventBus.LevelFailed.connect(_level_fail)
	visible = false
	
func _level_fail() -> void:
	text = 'LEVEL FAILED'
	visible = true
	
func _level_complete() -> void:
	text = 'LEVEL COMPLETE'
	visible = true
