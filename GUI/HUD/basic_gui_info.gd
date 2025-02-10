extends Control

@onready var remaining_prisoners: Label = $RemainingPrisoners
@onready var prisoners_in_helicopter: Label = $PrisonersInHelicopter
@onready var prisoners_saved: Label = $PrisonersSaved

# if our helicopter is full, we need to pulse to give visual feedback
@onready var heart_icon: Sprite2D = $"Heart-icon"
var _time_elapsed: float = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if is_instance_valid(Constants.player_reference) == false:
		return
	
	remaining_prisoners.text = str(Constants.level_total_remaining_prisoners)
	prisoners_in_helicopter.text = str(Constants.player_reference.prisoners_in_helicopter)
	prisoners_saved.text = str(Constants.level_total_prisoners_saved)
	
	_pulsate_passengers_in_helicopter(delta)
	
func _pulsate_passengers_in_helicopter(delta: float):
	_time_elapsed += delta
	if Constants.player_reference.is_helicopter_full():
		var new_scale: Vector2 =  Vector2(abs(sin(_time_elapsed)), abs(sin(_time_elapsed)))
		heart_icon.scale.x = clampf(new_scale.x, 0.5, 1.3) 
		heart_icon.scale.y =  clampf(new_scale.y, 0.5, 1.3) 
