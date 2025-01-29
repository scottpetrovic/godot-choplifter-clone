extends Area2D

# Properties for controlling the movement
@export var amplitude: float = 10.0  # How far the object moves left/right
@export var frequency: float = 0.5    # How fast the object moves
var time: float = 0.0                 # Time tracker for the sine wave
var initial_y: float                  # Store the starting X position

func _ready():
	# Store the initial x position when the node starts
	initial_y = position.y
	
	body_entered.connect(_body_enter)


func _body_enter(_body: Node2D) -> void:
	if _body == Constants.player_reference:
		var player: HelicopterPlayer = Constants.player_reference
		player.hit()
		
		# delete bird since we ran into it
		# TODO: maybe explosion of sorts
		queue_free()

func _process(delta):
	# Increment time
	time += delta
	
	# Calculate the new x position using sine wave
	# Sin function returns values between -1 and 1, which we multiply by amplitude
	var offset = amplitude * sin(time * frequency)
	
	# Update only the x position, keeping the original y position
	position.y = initial_y + offset
