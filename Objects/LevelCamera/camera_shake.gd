extends Node

@export var decay = 0.8  # How quickly the shaking stops [0, 1].
@export var max_offset = Vector2(20, 20)  # Maximum shake offset in pixels
@export var trauma = 0.0  # Current shake strength

# Current shake offset that can be read by the camera
var current_shake = Vector2.ZERO

func _process(delta):
	if trauma:
		# Reduce trauma over time
		trauma = max(trauma - decay * delta, 0)
		
		# Calculate shake strength
		var shake_amount = trauma * trauma
		
		# Generate random shake offset
		current_shake = Vector2(
			randf_range(-1, 1) * max_offset.x * shake_amount,
			randf_range(-1, 1) * max_offset.y * shake_amount
		)
	else:
		current_shake = Vector2.ZERO

func add_trauma(amount):
	trauma = min(trauma + amount, 1.0)
