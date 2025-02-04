extends Sprite2D

@export var min_flicker_time: float = 0.05
@export var max_flicker_time: float = 0.2
@export var visible_chance: float = 0.6
@export var max_rotation_degrees: float = 20.0  # Maximum rotation in either direction
@export var max_x_offset: float = 5.0         # Maximum horizontal movement in either direction

var initial_position: Vector2

func _ready() -> void:
	# Store the initial position
	initial_position = position
	flicker()

func flicker() -> void:
	while true:
		# Random visibility
		visible = randf() < visible_chance
		
		# Random rotation between -max_rotation and +max_rotation
		rotation_degrees = randf_range(-max_rotation_degrees, max_rotation_degrees)
		
		# Random x position offset from initial position
		position.x = initial_position.x + randf_range(-max_x_offset, max_x_offset)
		
		# Wait for next flicker
		await get_tree().create_timer(randf_range(min_flicker_time, max_flicker_time)).timeout
