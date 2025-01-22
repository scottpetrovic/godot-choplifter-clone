class_name HelicopterDirectionState
extends Node

# Define possible facing directions
enum FacingDirection {
	LEFT,
	DOWN,
	RIGHT	
}

@onready var helicopter_player: HelicopterPlayer = %Helicopter_Player

# Time tracking for direction changes
var last_input_time = 0.0
var input_pressed = false
var _input_tap_direction: int = 0
@export var tap_threshold = 0.2  # Adjust this value for what counts as a "tap"

# State variables
var current_direction = FacingDirection.RIGHT

signal direction_changed(new_direction)
signal hostages_changed(count)

func set_direction(direction: FacingDirection):
	if current_direction != direction:
		current_direction = direction
		direction_changed.emit(current_direction)

func get_direction() -> FacingDirection:
	return current_direction
	
func update_facing_direction():
	if _input_tap_direction < 0:
		# left clicked
		if get_direction() == FacingDirection.RIGHT:
			set_direction(FacingDirection.DOWN)
		elif get_direction() == FacingDirection.DOWN:
			set_direction(FacingDirection.LEFT)
		# if facing left, stay left (no change needed)
	elif _input_tap_direction > 0:
		# right clicked
		if get_direction() == FacingDirection.LEFT:
			set_direction(FacingDirection.DOWN)
		elif get_direction() == FacingDirection.DOWN:
			set_direction(FacingDirection.RIGHT)
		# if facing right, stay right (no change needed)

func _process(delta: float) -> void:
	_handle_input_direction_or_movement_logic(delta)
	print(get_direction())
	
	
func _handle_input_direction_or_movement_logic(delta: float) -> void:
		# Handle direction changes based on taps
	if Input.is_action_just_pressed("ui_left") or Input.is_action_just_pressed("ui_right"):
		input_pressed = true
		_input_tap_direction = helicopter_player.direction_input.x
		last_input_time = 0.0
	elif Input.is_action_just_released("ui_left") or Input.is_action_just_released("ui_right"):
		if last_input_time <= tap_threshold:
			update_facing_direction()
		input_pressed = false
	
	# Update timer if input is being held
	if input_pressed:
		last_input_time += delta
