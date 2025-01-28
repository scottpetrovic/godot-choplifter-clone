extends Node


var colors = [Color.WHITE, Color.BLACK]
var current_color = 0
var blink_interval = 0.1  # Seconds between color changes

@onready var color_rect: ColorRect = $"../ColorRect"


func _ready():
	# Start the blinking
	var timer = Timer.new()
	add_child(timer)
	timer.wait_time = blink_interval
	timer.connect("timeout", _on_timer_timeout)
	timer.start()

func _on_timer_timeout():
	current_color = (current_color + 1) % 2
	color_rect.modulate = colors[current_color]
