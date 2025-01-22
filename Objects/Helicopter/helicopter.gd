class_name HelicopterPlayer
extends CharacterBody2D

@export var speed = 80.0

var direction_input: Vector2 = Vector2.ZERO

func _physics_process(_delta):
	# Get input values (-1, 0, or 1 for each axis)
	direction_input = Vector2(
		Input.get_axis("ui_left", "ui_right"),
		Input.get_axis("ui_up", "ui_down")
	)
	
	# Set velocity based on input direction and speed
	velocity = direction_input * speed
	
	# Apply the movement
	move_and_slide()
	
