extends Label


func _process(_delta: float) -> void:
	text = str(Constants.level_score).pad_zeros(7)
