extends Control

@onready var level_win_label: Label = $LevelWinLabel

@onready var level_score: Label = $LevelScore
@onready var prisoners_saved: Label = $PrisonersSaved
@onready var global_score: Label = $GlobalScore

@onready var next_level_button: Button = $VBoxContainer/NextLevelButton
@onready var main_menu_button: Button = $VBoxContainer/MainMenuButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print('loading win screen')
	level_win_label.text = 'LEVEL ' +str(Constants.current_level+1) + ' COMPLETE'
	
	# if we finished all the levels, cannot go to next level
	if Constants.does_next_level_exist() == false:
		next_level_button.visible = false
		level_win_label.text = "GAME COMPLETE"	
	
	next_level_button.pressed.connect(next_level_click)
	main_menu_button.pressed.connect(main_menu_click)
	
	# scores for level
	level_score.text = 'LEVEL SCORE: ' + str(Constants.level_score).pad_zeros(7)
	global_score.text = 'TOTAL SCORE: ' + str(Constants.global_score).pad_zeros(7)
	prisoners_saved.text = 'PRISONERS RESCUED: ' + str(Constants.level_total_prisoners_saved)

	

func next_level_click() -> void:
	Constants.go_to_next_level()


func main_menu_click() -> void:
	Constants.go_to_main_menu()
