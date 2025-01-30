extends Node

enum PlayerFacingDirection { LEFT,DOWN,RIGHT }
enum PrisonerObjective { GET_IN_HELICOPTOR,GET_IN_BASE }
enum PowerUpType { NONE,BOMBS }

# global way for other objects to reference player
var player_reference: HelicopterPlayer = null

var starting_lives: int = 2
var lives_left: int = starting_lives
var current_level: int = 0
var global_score: int = 0

var level_paths: Array[String] = [
	"res://Scenes/Levels/Level1.tscn",
	"res://Scenes/Levels/Level2.tscn"]
	

# objects to spawn (maybe put in separate global if this gets too large
const EXPLOSION = preload("res://Objects/Explosion/Explosion.tscn")
	

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
	get_tree().change_scene_to_file(level_paths[current_level])

func does_next_level_exist() -> bool:
	return current_level < level_paths.size()-1

func go_to_next_level() -> void:
	current_level += 1
	level_total_prisoners_saved = 0
	reset_existing_level()

func start_new_game() -> void:
	current_level = 0
	level_total_prisoners_saved = 0
	reset_existing_level()
		

func go_to_main_menu() -> void:
	get_tree().change_scene_to_file("res://Scenes/MainMenu/MainMenu.tscn")

func go_to_level_win_summary() -> void:
	await get_tree().create_timer(5.0).timeout
	get_tree().change_scene_to_file("res://Scenes/LevelWinSummary/LevelWinSummary.tscn")

func go_to_gameover_screen() -> void:
	get_tree().change_scene_to_file("res://Scenes/GameOver/GameOver.tscn")


func spawn_explosion(pos: Vector2) -> void:
	var expl: Node2D = EXPLOSION.instantiate()
	get_tree().current_scene.add_child(expl)
	expl.global_position = pos
