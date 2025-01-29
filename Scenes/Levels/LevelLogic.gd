extends Node2D

@onready var level_objectives: CanvasLayer = $LevelObjectives



func _ready():
	await get_tree().process_frame # make sure all children loaded before continuing
	Constants.level_total_remaining_prisoners = _caculate_total_prisoners_for_level()
	
	EventBus.LevelComplete.connect(_level_complete)
	EventBus.LevelFailed.connect(_level_fail)


func _level_fail() -> void:
	await get_tree().create_timer(5.0).timeout
	
	if Constants.lives_left <= 0:
		Constants.go_to_gameover_screen()
		return
	
	Constants.lives_left -= 1
	Constants.player_reference.reset_player_after_loss()
	level_objectives.get_node("layout").show_screen_on_level_fail()

func _level_complete() -> void:
	await get_tree().create_timer(5.0).timeout
	Constants.go_to_level_win_summary()
	

func _caculate_total_prisoners_for_level() -> int:
	var prisoner_camps: Array[Node] = get_tree().get_nodes_in_group("PrisonerCamp")
	
	var total_initial_prisoners = 0
	for camp in prisoner_camps:
		total_initial_prisoners += camp.prisoners_held_captive
		
	return total_initial_prisoners
