extends Node


var colors = ["#c4f0c2", "#2d1b04"]
var current_color_index: int = 0
var blink_interval = 0.1  # Seconds between color changes

@onready var color_rect: ColorRect = $"../ColorRect"


func _ready():
	# Start the blinking
	var timer = Timer.new()
	add_child(timer)
	timer.wait_time = blink_interval
	timer.connect("timeout", _change_color)
	timer.start()
	
	_change_color()

func _change_color():
	if current_color_index == 0:
		current_color_index = 1
	else:
		current_color_index = 0
	
	color_rect.modulate = colors[current_color_index]
