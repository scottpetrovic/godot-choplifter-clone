extends Node

enum PlayerFacingDirection { LEFT,DOWN,RIGHT }
enum PrisonerObjective { GET_IN_HELICOPTOR,GET_IN_BASE }
enum PowerUpType { NONE,BOMBS }

# global way for other objects to reference player
var player_reference: HelicopterPlayer = null
var player_direction: PlayerFacingDirection = PlayerFacingDirection.LEFT

var starting_lives: int = 2
var lives_left: int = starting_lives
var current_level: int = 1

# active level specific data 
# These will get wiped out when resetting or changing levels
var level_total_remaining_prisoners: int = 0
var level_total_prisoners_saved: int = 0
var level_active_powerup: PowerUpType = PowerUpType.NONE
var level_score: int = 0

func reset_existing_level() -> void:
	level_active_powerup = PowerUpType.NONE
	level_score = 0
	lives_left = starting_lives
	get_tree().change_scene_to_file("res://Scenes/InGame/InGame.tscn")

func start_new_game() -> void:
	current_level = 1
	reset_existing_level()
	

func go_to_main_menu() -> void:
	get_tree().change_scene_to_file("res://Scenes/MainMenu/MainMenu.tscn")


func _process(_delta: float) -> void:
	if is_instance_valid(player_reference) && player_reference:
		var logic_node: HelicopterDirectionState = player_reference.get_node("HelicopterDirectionLogic")
		player_direction = logic_node.get_direction()
