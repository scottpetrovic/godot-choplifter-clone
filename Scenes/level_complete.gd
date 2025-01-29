extends Control

@onready var level_over_message: Label = $LevelOverMessage

func _ready() -> void:
	EventBus.LevelComplete.connect(_level_complete)
	EventBus.LevelFailed.connect(_level_fail)
	visible = false
	
func _level_fail() -> void:
	level_over_message.text = 'LEVEL FAILED'
	visible = true
	
func _level_complete() -> void:
	level_over_message.text = 'LEVEL COMPLETE'
	visible = true
