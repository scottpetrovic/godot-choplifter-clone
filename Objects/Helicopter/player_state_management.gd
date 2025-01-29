class_name HelicopterDirectionState
extends Node

# Time tracking for direction changes
var last_tap_time = 0.0
var last_tap_direction = ""  # Store the action name instead of direction value
var double_tap_threshold = 0.2  # Adjust this value for what counts as a "double tap"

# State variables
var current_direction = Constants.PlayerFacingDirection.RIGHT

func get_direction() -> Constants.PlayerFacingDirection:
	return current_direction
	
func set_direction(direct: Constants.PlayerFacingDirection) -> void:
	current_direction = direct
	
func update_facing_direction(action: String, is_double_tap: bool):
	
	if is_double_tap == false: return

	match action:
		"ui_down": current_direction = Constants.PlayerFacingDirection.DOWN
		"ui_left": current_direction =  Constants.PlayerFacingDirection.LEFT
		"ui_right": current_direction = Constants.PlayerFacingDirection.RIGHT

func _process(delta: float) -> void:
	handle_input_direction_or_movement_logic(delta)
	
func handle_input_direction_or_movement_logic(_delta: float) -> void:
	var current_time = Time.get_ticks_msec() / 1000.0
	
	# Check for double-taps on all directions
	for action in ["ui_down", "ui_left", "ui_right"]:
		if Input.is_action_just_pressed(action):
			var in_double_tap_threshold = (current_time - last_tap_time) <= double_tap_threshold
			var is_double_tap_success = action == last_tap_direction and in_double_tap_threshold
			
			update_facing_direction(action, is_double_tap_success)
			last_tap_direction = action
			last_tap_time = current_time
			return
