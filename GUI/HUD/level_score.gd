extends Label

func _ready() -> void:
	EventBus.BonusHostageSaved.connect(_bonus_hostage_saved)

func _process(_delta: float) -> void:
	text = str(Constants.current_score()).pad_zeros(7)


func _bonus_hostage_saved() -> void:
	# make the label blink a couple of times
	visible = false  # Invisible for 0.5 seconds
	await get_tree().create_timer(0.25).timeout
	visible = true # Visible for 1 second
