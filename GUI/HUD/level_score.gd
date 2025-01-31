extends Label


func _process(_delta: float) -> void:
	text = str(Constants.global_score).pad_zeros(7)
