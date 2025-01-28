class_name Prisoner
extends Area2D

@export var move_speed = 13.0  # Speed at which prisoner moves to helicopter
@export var distance_to_watch_for_player: int = 60 # in pixels

var _distance_to_player: float = 0.0

var _objective: Constants.PrisonerObjective = Constants.PrisonerObjective.GET_IN_HELICOPTOR

enum PrisonerBehaviorState {
	IDLE,
	WALK
}
var prisoner_state: PrisonerBehaviorState = PrisonerBehaviorState.IDLE


enum PrisonerDirection {
	LEFT,
	RIGHT
}
var prisoner_facing_direction: PrisonerDirection = PrisonerDirection.LEFT

func set_objective(obj: Constants.PrisonerObjective) -> void:
	_objective = obj

func _process(delta: float) -> void:
	
	prisoner_state = PrisonerBehaviorState.IDLE
	
	# the base is always to the right, so run that
	if _objective == Constants.PrisonerObjective.GET_IN_BASE:
		global_position.x += move_speed * delta
		prisoner_state = PrisonerBehaviorState.WALK
		return
	
	# The helicoptor could be on either side, so go that direction 
	if _objective == Constants.PrisonerObjective.GET_IN_HELICOPTOR:
		_distance_to_player = global_position.distance_to(Constants.player_reference.global_position)
		walk_toward_player(delta)
		
		# if we are inside helicoptor, signal that we are saved
		var _distance_to_be_saved: float = 10
		if _distance_to_player < _distance_to_be_saved:
			Constants.prisoner_captured()
			queue_free()


func walk_toward_player(delta: float) -> void:
	# If player is landed and close enough, move towards them
	if Constants.player_reference.is_on_floor() and _distance_to_player < distance_to_watch_for_player:  # 50 pixels, adjust as needed
		# Get direction to player
		var direction = (Constants.player_reference.global_position - global_position).normalized()
		
		# Move towards player
		global_position.x += direction.x * move_speed * delta
		
		prisoner_state = PrisonerBehaviorState.WALK
		
		if direction.x > 0:
			prisoner_facing_direction = PrisonerDirection.RIGHT
		else:
			prisoner_facing_direction = PrisonerDirection.LEFT
