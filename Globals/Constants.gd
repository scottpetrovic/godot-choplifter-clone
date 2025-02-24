extends Node

enum PlayerFacingDirection { LEFT,DOWN,RIGHT }

enum PrisonerObjective { GET_IN_HELICOPTOR,GET_IN_BASE }
enum PrisonerBehaviorState { IDLE, WALK }
enum PrisonerDirection { LEFT, RIGHT }
enum PowerUpType { NONE,BOMBS, ROPE }
enum EnvironmentStage {JUNGLE, OCEAN, CITY}

var current_environment_stage: EnvironmentStage = EnvironmentStage.JUNGLE

# global way for other objects to reference player
var player_reference: HelicopterPlayer = null

var starting_lives: int = 1
var lives_left: int = starting_lives

 # when we start loading levels, this will change to 0 for first level
var current_level: int = -1 # -1 is default


var level_data: Array = [
		{
			"level_scene": "res://Scenes/Levels/Level1.tscn",
			"map_change": EnvironmentStage.JUNGLE
		},
		{
			"level_scene": "res://Scenes/Levels/Level2.tscn"
		},
		{
			"level_scene": "res://Scenes/Levels/Level3.tscn"
		},
		{
			"level_scene": "res://Scenes/Levels/Level4.tscn",
			"map_change": EnvironmentStage.OCEAN
		},
		{
			"level_scene": "res://Scenes/Levels/Level5.tscn"
		},
		{
			"level_scene": "res://Scenes/Levels/Level6.tscn"
		},
		{
			"level_scene": "res://Scenes/Levels/Level7.tscn",
			"map_change": EnvironmentStage.CITY
		},
		{
			"level_scene": "res://Scenes/Levels/Level8.tscn"
		},
		{
			"level_scene": "res://Scenes/Levels/Level9.tscn"
		}
		
	]

# objects to spawn (maybe put in separate global if this gets too large
const EXPLOSION = preload("res://Objects/Explosion/Explosion.tscn")
const BONUS_STAR = preload("res://Objects/BonusStar/BonusStar.tscn")
	

# active level specific data 
# These will get wiped out when resetting or changing levels
var level_total_remaining_prisoners: int = 0
var level_total_prisoners_saved: int = 0
var level_active_powerup: PowerUpType = PowerUpType.NONE
var level_min_prisoners_to_success: int = 0 # level will set this when loaded
var _global_score: int = 0

func current_score() -> int:
	return _global_score

func add_to_score(amount: int) -> void:
	
	# every 1,000 points, we will get a new life (lives_left)
	# if we went up 1,000 points, we will trigger a new life
	var previous_milestone: int = floor(float(_global_score) / 1000.0)
	_global_score += amount
	var new_milestone: int = floor( float(_global_score) / 1000.0)
	
	if new_milestone > previous_milestone:
		lives_left += 1
		GlobalAudio.play_sfx_level_up()


func reset_existing_level(reset_lives: bool = true) -> void:
	level_active_powerup = PowerUpType.NONE
	level_total_prisoners_saved = 0
	
	if reset_lives:
		lives_left = starting_lives
	
	get_tree().change_scene_to_file(level_data[current_level].level_scene)

func does_next_level_exist() -> bool:
	return current_level < level_data.size()-1

func go_to_next_level() -> void:
	current_level += 1
	
	# Do we have a map change element on level?
	if "map_change" in level_data[current_level]:
		current_environment_stage = level_data[current_level].map_change
		go_to_instructions_screen()
	else:
		reset_existing_level(false)


func start_first_level() -> void:
	current_level = 0
	reset_existing_level(false)

func go_to_world_map() -> void:
	get_tree().change_scene_to_file("res://Scenes/WorldMap/WorldMap.tscn")

func go_to_instructions_screen() -> void:
	get_tree().change_scene_to_file("res://Scenes/Instructions/Instructions.tscn")

func go_to_main_menu() -> void:
	get_tree().change_scene_to_file("res://Scenes/MainMenu/MainMenu.tscn")

func go_to_level_win_summary() -> void:
	await get_tree().create_timer(5.0).timeout
	get_tree().change_scene_to_file("res://Scenes/LevelSummary/LevelSummary.tscn")

func go_to_gameover_screen() -> void:
	get_tree().change_scene_to_file("res://Scenes/GameOver/GameOver.tscn")

func add_camera_shake(amount: float = 0.4) -> void:
	var camera_node: Camera2D = get_viewport().get_camera_2d()
	
	if camera_node:
		camera_node.get_node("CameraShake").add_trauma(amount)

func spawn_explosion(pos: Vector2) -> void:
	var expl: Node2D = EXPLOSION.instantiate()
	get_tree().current_scene.add_child(expl)
	expl.global_position = pos

func spawn_bonus_star_on_chance(pos: Vector2) -> void:
	# only have % chance of spawning this object
	# Only spawn if roll is less than 0.05 (5% chance)
	if randf() < .05:
		var star: Node2D = BONUS_STAR.instantiate()
		#get_tree().current_scene.call_deferred("add_child", star)
		get_tree().current_scene.add_child(star)
		star.global_position = pos
	
	
