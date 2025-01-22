extends Label

func _ready() -> void:
	EventBus.LevelComplete.connect(_level_complete)
	visible = false
	
func _level_complete() -> void:
	visible = true
