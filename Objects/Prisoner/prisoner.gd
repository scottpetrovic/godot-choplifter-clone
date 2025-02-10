class_name Prisoner
extends Area2D

@onready var prisoner_movement: PrisonerMovement = $PrisonerMovement

@export var health: int = 2 # prisoner can die


func _ready() -> void:
	body_entered.connect(_body_enter)
	
func _body_enter(body: Node2D) -> void:
	
	# helicopter is full, so we cannot go in
	if Constants.player_reference.is_helicopter_full():
		return
	
	# if we are inside helicoptor, signal that we are saved
	# I think we are dying right when we spawn
	# when prisoners get out of the helicopter to return to base, we don't want this
	# to go off
	if prisoner_movement._objective == Constants.PrisonerObjective.GET_IN_HELICOPTOR:
		if body == Constants.player_reference:
			Constants.level_total_remaining_prisoners -= 1
			Constants.player_reference.prisoners_in_helicopter += 1
			GlobalAudio.play_sfx_prisoner_pickup()
			queue_free()

func hit(damage: int = 1) -> void:
	health -= damage
	
	if health <= 0:
		Constants.level_total_remaining_prisoners -= 1
		queue_free() # DEATH!

func set_objective(obj: Constants.PrisonerObjective) -> void:
	prisoner_movement._objective = obj

func returned_to_base() -> void:
	# when prisoners runs through door, the home base will
	# call this for the prisoner
	Constants.level_total_prisoners_saved += 1
	
	# Adding points logic
	# if we are above minimum required, give more points
	if Constants.level_min_prisoners_to_success < Constants.level_total_prisoners_saved:
		Constants.add_to_score(200)
		GlobalAudio.play_sfx_prisoner_pickup( 0.6) # a bit different since more of a score
	else:
		Constants.add_to_score(20) # points for bringing prisoner back
		GlobalAudio.play_sfx_prisoner_pickup()
	

	queue_free()

func climb_ladder() -> void:
	prisoner_movement.is_climbing_ladder = true

func prisoner_state() -> Constants.PrisonerBehaviorState:
	return prisoner_movement._state
	
	
func grab_onto_ladder() -> void:
	# assign yourself to the helicopter instance 	
	if get_parent() != Constants.player_reference:
		reparent(Constants.player_reference.rope_object_reference())
	
	
func facing_direction() -> Constants.PrisonerDirection:
	return prisoner_movement._facing_direction

	
	
