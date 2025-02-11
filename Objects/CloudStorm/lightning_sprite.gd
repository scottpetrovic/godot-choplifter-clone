extends Sprite2D

@export var min_flicker_time: float = 0.05
@export var max_flicker_time: float = 0.2
@export var visible_chance: float = 0.6
@export var max_rotation_degrees: float = 20.0
@export var max_x_offset: float = 5.0

var initial_position: Vector2
var flicker_timer: float = 0.0
var next_flicker_time: float = 0.0

func _ready() -> void:
	initial_position = position
	# Set initial flicker time
	next_flicker_time = randf_range(min_flicker_time, max_flicker_time)

func _process(delta: float) -> void:
	flicker_timer += delta
	
	if flicker_timer >= next_flicker_time:
		# Reset timer and set next interval
		flicker_timer = 0.0
		next_flicker_time = randf_range(min_flicker_time, max_flicker_time)
		
		# Apply flicker effects
		visible = randf() < visible_chance
		rotation_degrees = randf_range(-max_rotation_degrees, max_rotation_degrees)
		position.x = initial_position.x + randf_range(-max_x_offset, max_x_offset)
