extends Sprite2D

@export var bob_height : float = 5.0  # Maximum height of bob in pixels
@export var bob_speed : float = 1.0    # Speed of bobbing motion
@export_range(0, 360) var start_angle : float = 0.0  # Starting angle of the bob

var time : float = 0.0
var initial_y : float

func _ready():
	# Store the initial Y position
	initial_y = position.y
	# Convert start angle to radians and set initial time
	time = deg_to_rad(start_angle)

func _process(delta):
	# Increment time
	time += bob_speed * delta
	
	# Calculate new Y position using sine wave
	var new_y = initial_y + sin(time) * bob_height
	
	# Update position
	position.y = new_y
