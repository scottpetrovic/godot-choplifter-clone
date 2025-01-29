extends Node

enum PlayerFacingDirection {
	LEFT,
	DOWN,
	RIGHT	
}

enum PrisonerObjective {
	GET_IN_HELICOPTOR,
	GET_IN_BASE
}

enum PowerUpType {
	NONE,
	BOMBS
}

# global way for other objects to reference player
var player_reference: HelicopterPlayer = null
var player_direction: PlayerFacingDirection = PlayerFacingDirection.LEFT

# active level specific data
var level_total_remaining_prisoners: int = 0
var level_total_prisoners_saved: int = 0
var level_active_powerup: PowerUpType = PowerUpType.NONE
var level_score: int = 0

func prisoner_captured() -> void:
	level_total_remaining_prisoners -= 1
	player_reference.prisoners_in_helicopter += 1
	

func _process(delta: float) -> void:
	if is_instance_valid(player_reference) && player_reference:
		var logic_node: HelicopterDirectionState = player_reference.get_node("HelicopterDirectionLogic")
		player_direction = logic_node.get_direction()
