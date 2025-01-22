extends Node

enum PlayerFacingDirection {
	LEFT,
	DOWN,
	RIGHT	
}

# global way for other objects to reference player
var player_reference: HelicopterPlayer = null
