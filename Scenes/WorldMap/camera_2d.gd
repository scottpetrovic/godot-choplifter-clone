extends Camera2D

@export var target: Node2D
@export var follow_speed: float = 5.0  # Adjust this value to control smoothness

func _process(delta: float) -> void:
	# Smoothly interpolate the camera position towards the target
	global_position = global_position.lerp(target.global_position, follow_speed * delta)
