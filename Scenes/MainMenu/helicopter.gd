extends Sprite2D

@export var jitter_intensity: float = 0.5
@export var jitter_speed: float = 3.0

var initial_position: Vector2
var time: float = 0.0

func _ready():
	initial_position = position

func _process(delta):
	time += delta
	
	# Create random offset using sine waves at different frequencies
	var offset = Vector2(
		sin(time * jitter_speed) * jitter_intensity + cos(time * jitter_speed * 1.3) * jitter_intensity * 0.5,
		sin(time * jitter_speed * 1.1) * jitter_intensity + cos(time * jitter_speed * 0.7) * jitter_intensity * 0.5
	)
	
	position = initial_position + offset
