class_name Prisoner
extends Area2D

@onready var prisoner_movement: PrisonerMovement = $PrisonerMovement

@export var health: int = 2 # prisoner can die

func set_objective(obj: Constants.PrisonerObjective) -> void:
	prisoner_movement._objective = obj

func climb_ladder() -> void:
	prisoner_movement.is_climbing_ladder = true

func prisoner_state() -> Constants.PrisonerBehaviorState:
	return prisoner_movement._state
	
	
func facing_direction() -> Constants.PrisonerDirection:
	return prisoner_movement._facing_direction

	
	
