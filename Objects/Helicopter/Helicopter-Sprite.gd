extends Sprite2D

@onready var helicopter_direction_logic: HelicopterDirectionState = $"../HelicopterDirectionLogic"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if helicopter_direction_logic.get_direction() == Constants.PlayerFacingDirection.LEFT:
		texture = load("res://Objects/Helicopter/helicopter-facing-left.png")
		flip_h = false
	elif helicopter_direction_logic.get_direction() == Constants.PlayerFacingDirection.RIGHT:
		texture =  load("res://Objects/Helicopter/helicopter-facing-left.png")
		flip_h = true
	else:
		texture = load("res://Objects/Helicopter/helicopter-facing-down.png")
