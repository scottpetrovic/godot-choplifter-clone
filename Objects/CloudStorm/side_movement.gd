extends Node

# Properties for controlling the movement
@export var amplitude: float = 10.0  # How far the object moves left/right
@export var frequency: float = 0.5    # How fast the object moves
var time: float = 0.0                 # Time tracker for the sine wave
var initial_x: float                  # Store the starting X position


func _ready():
	# Store the initial x position when the node starts
	initial_x = get_parent().position.x

func _process(delta):
	time += delta # Increment time
	
	_move_side_to_side()
	
	
func _move_side_to_side() -> void:
	# Calculate the new x position using sine wave
	# Sin function returns values between -1 and 1, which we multiply by amplitude
	var offset = amplitude * sin(time * frequency)
	
	# Update only the x position, keeping the original y position
	get_parent().position.x = initial_x + offset
