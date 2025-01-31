extends Node

@onready var level_objectives: CanvasLayer = $"../LevelObjectives"
@export var starting_direction: Constants.PlayerFacingDirection = Constants.PlayerFacingDirection.LEFT

@onready var helicopter_player: HelicopterPlayer = $"../Helicopter_Player"

@export var min_prisoners_required_for_success: int = 4

func _ready():
	await get_tree().process_frame # make sure all children loaded before continuing
	Constants.level_total_remaining_prisoners = _caculate_total_prisoners_for_level()
	
	EventBus.LevelComplete.connect(_level_complete)
	EventBus.LevelFailed.connect(_level_fail)
	
	# set player reference for level as constant
	Constants.player_reference = helicopter_player
	Constants.player_reference.set_facing_direction(starting_direction)
	Constants.level_min_prisoners_to_success = min_prisoners_required_for_success

func _level_fail() -> void:
	await get_tree().create_timer(5.0).timeout
	
	if Constants.lives_left <= 0:
		Constants.go_to_gameover_screen()
		return
	
	Constants.lives_left -= 1
	Constants.player_reference.reset_player_after_loss()
	level_objectives.get_node("layout").show_screen_on_level_fail()

func _level_complete() -> void:
	Constants.go_to_level_win_summary()


func _caculate_total_prisoners_for_level() -> int:
	var prisoner_camps: Array[Node] = get_tree().get_nodes_in_group("PrisonerCamp")
	
	var total_initial_prisoners = 0
	for camp in prisoner_camps:
		total_initial_prisoners += camp.prisoners_held_captive
		
	return total_initial_prisoners
