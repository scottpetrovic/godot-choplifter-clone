extends Timer

@onready var health_bar: Control = $".."

func _ready() -> void:
	# Connect the timer's timeout signal
	timeout.connect(_on_timeout)

func _process(_delta: float) -> void:
	# Start/stop timer based on health status
	if health_bar.is_low_on_health():
		if is_stopped():  # Changed to is_stopped()
			start()
	else:
		if not is_stopped():   # Changed to not is_stopped()
			stop()
			health_bar.health_bar.visible = true  # Reset visibility when health is restored

func _on_timeout() -> void:
	if health_bar.is_low_on_health():
		# Toggle the health bar sprite visibility
		health_bar.health_bar.visible = !health_bar.health_bar.visible
