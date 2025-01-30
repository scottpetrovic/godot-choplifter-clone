extends Node

# Movement constants
const SPEED = 7
const PATROL_DISTANCE = 40

# State variables
var initial_position = Vector2.ZERO

enum DIRECTION { LEFT, RIGHT }
var current_direction = DIRECTION.RIGHT

# Reference to parent Area2D
@onready var parent = get_parent()
@onready var wait_timer: Timer = $"../WaitTimer"

func _ready():
	# Store the initial position of the parent Area2D
	initial_position = parent.global_position
	
	# Create and set up the timer if it doesn't exist
	wait_timer.one_shot = true
	wait_timer.wait_time = 1.0  # 1 second pause
	wait_timer.timeout.connect(_on_wait_timer_timeout)


func _process(delta):
	if wait_timer.is_stopped():
		move_parent(delta)

func move_parent(delta):
	var movement = Vector2.ZERO
	
	match current_direction:
		DIRECTION.RIGHT:
			# Check if we haven't reached the right patrol point yet
			if parent.global_position.x < initial_position.x + PATROL_DISTANCE:
				movement.x = SPEED * delta # Continue moving right
			else:
				wait_timer.start() # Reached right patrol point
		DIRECTION.LEFT:
			# Check if we haven't reached the left patrol point yet
			if parent.global_position.x > initial_position.x:
				movement.x = -SPEED * delta # Continue moving left
			else:
				wait_timer.start() # Reached left patrol point
	
	# Update parent position
	parent.global_position += movement

func _on_wait_timer_timeout():
	# Switch direction between LEFT and RIGHT
	if current_direction == DIRECTION.RIGHT: 
		current_direction = DIRECTION.LEFT
		return

	current_direction = DIRECTION.RIGHT
	
