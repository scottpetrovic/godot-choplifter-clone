extends Control

@onready var remaining_prisoners: Label = $RemainingPrisoners
@onready var prisoners_in_helicopter: Label = $PrisonersInHelicopter
@onready var prisoners_saved: Label = $PrisonersSaved


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	remaining_prisoners.text = str(Constants.level_total_remaining_prisoners)
	prisoners_in_helicopter.text = str(Constants.player_reference.prisoners_in_helicopter)
	prisoners_saved.text = str(Constants.level_total_prisoners_saved)
	
