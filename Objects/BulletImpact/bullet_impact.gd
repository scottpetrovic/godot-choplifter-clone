extends Node2D

@export var lifetime: float = 0.2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	lifetime -= delta
	
	if lifetime <= 0.0:
		queue_free()
