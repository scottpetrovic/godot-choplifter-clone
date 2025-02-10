extends Label


func _process(_delta: float) -> void:
	text = str(Constants.current_score()).pad_zeros(7)
