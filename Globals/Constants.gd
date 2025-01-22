extends Node

enum PlayerFacingDirection {
	LEFT,
	DOWN,
	RIGHT	
}

# global way for other objects to reference player
var player_reference: HelicopterPlayer = null
var player_direction: PlayerFacingDirection = PlayerFacingDirection.LEFT

func _process(delta: float) -> void:
	if player_reference:
		var logic_node: HelicopterDirectionState = player_reference.get_node("HelicopterDirectionLogic")
		player_direction = logic_node.get_direction()
