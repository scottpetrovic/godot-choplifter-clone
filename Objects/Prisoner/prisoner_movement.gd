class_name PrisonerMovement
extends Node

@export var move_speed = 16.0  # Speed at which prisoner moves to helicopter
@export var distance_to_watch_for_player: int = 60 # in pixels

var _distance_to_player: float = 0.0
@onready var prisoner: Prisoner = $".."


# what is on the prisoner's mind. They either need to get in the helicopter
# of they need to get to the base HQ to be saved
var _objective: Constants.PrisonerObjective = Constants.PrisonerObjective.GET_IN_HELICOPTOR

var _state: Constants.PrisonerBehaviorState = Constants.PrisonerBehaviorState.IDLE


var _facing_direction: Constants.PrisonerDirection = Constants.PrisonerDirection.LEFT
var is_climbing_ladder: bool = false

func walk_toward_player(delta: float) -> void:
	# If player is landed and close enough, move towards them
	if Constants.player_reference.is_on_floor() and _distance_to_player < distance_to_watch_for_player:  # 50 pixels, adjust as needed
		# Move towards player
		prisoner.global_position.x += _direction_towards_player().x * move_speed * delta
		_state = Constants.PrisonerBehaviorState.WALK

func _process(delta: float) -> void:
	# we made contact with a ladder, go up!
	if is_climbing_ladder:
		prisoner.global_position.y -= move_speed * delta
		return
	
	_state = Constants.PrisonerBehaviorState.IDLE
	_update_facing_direction()
	
	# the base is always to the right, so run that
	if _objective == Constants.PrisonerObjective.GET_IN_BASE:
		prisoner.global_position.x += move_speed * delta
		_state = Constants.PrisonerBehaviorState.WALK
		return
	
	# The helicoptor could be on either side, so go that direction 
	if _objective == Constants.PrisonerObjective.GET_IN_HELICOPTOR:
		_distance_to_player = prisoner.global_position.distance_to(Constants.player_reference.global_position)
		walk_toward_player(delta)
		
		# if we are inside helicoptor, signal that we are saved
		var _distance_to_be_saved: float = 10
		if _distance_to_player < _distance_to_be_saved:
			_prisoner_captured()
			prisoner.queue_free()
		
func _update_facing_direction() -> void:
	# base HQ is always on right side for now
	if _objective == Constants.PrisonerObjective.GET_IN_BASE:
		_facing_direction = Constants.PrisonerDirection.RIGHT
		
	# face direction of helicopter
	if _objective == Constants.PrisonerObjective.GET_IN_HELICOPTOR:
		if _direction_towards_player().x > 0:
			_facing_direction = Constants.PrisonerDirection.RIGHT
		else:
			_facing_direction = Constants.PrisonerDirection.LEFT

func _prisoner_captured() -> void:
	Constants.level_total_remaining_prisoners -= 1
	Constants.player_reference.prisoners_in_helicopter += 1


func _direction_towards_player() -> Vector2:
	return (Constants.player_reference.global_position - prisoner.global_position).normalized()
