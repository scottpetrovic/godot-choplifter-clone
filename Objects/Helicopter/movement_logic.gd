extends Node

@onready var parent: HelicopterPlayer = $".."
@export var speed = 80.0

var direction_input: Vector2 = Vector2.ZERO

func _physics_process(_delta):
	
	# we are dead, or level is over. stop processing input
	if parent.health <= 0 || parent.enable_movement == false: 
		return
	
	# Get input values (-1, 0, or 1 for each axis)
	direction_input = Vector2(
		Input.get_axis("ui_left", "ui_right"),
		Input.get_axis("ui_up", "ui_down")
	)

	# if we are touched down, we cannot move left or right
	if parent.is_on_floor():
		direction_input.x = 0
	
	# Set velocity based on input direction and speed
	parent.velocity = direction_input * speed
	
	# Apply the movement
	parent.move_and_slide()
	
