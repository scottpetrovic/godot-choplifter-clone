extends Camera2D

@export var target_path: NodePath
@export var smooth_speed: float = 5.0

var target: Node2D
var initial_vertical_position: float

func _ready():
	if target_path:
		target = get_node(target_path)
		
	# Store the initial vertical position of the camera
	# this will lock the camera vertically
	# so we can only go side to side
	initial_vertical_position = global_position.y

func _physics_process(delta):
	if target:
		# Create target position using helicopter's x position but keeping initial y position
		var target_position = Vector2(target.global_position.x, initial_vertical_position)
		
		# Smoothly move camera but only on x axis
		global_position = global_position.lerp(target_position, smooth_speed * delta)
