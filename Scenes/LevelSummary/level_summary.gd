extends Control

@onready var level_summary_label: Label = $LevelWinLabel
@onready var level_message: Label = $LevelMessage


@onready var prisoners_saved: Label = $PrisonersSaved
@onready var global_score: Label = $GlobalScore

@onready var next_level_button: Button = $VBoxContainer/NextLevelButton
@onready var main_menu_button: Button = $VBoxContainer/MainMenuButton
@onready var retry_level_button: Button = $VBoxContainer/RetryLevelButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	main_menu_button.pressed.connect( func(): Constants.go_to_main_menu() ) # always ok to go to
	
	# the only thing that matters is we saved minimum prisoners from level
	var is_level_success: bool = Constants.level_min_prisoners_to_success <= Constants.level_total_prisoners_saved
	if is_level_success:
		_updates_for_success()
	else:
		_updates_for_failure()


func _updates_for_failure() -> void:
	level_summary_label.text = 'LEVEL ' +str(Constants.current_level+1) + ' FAILURE'
	level_message.text = "YOU DIDN'T SAVE ENOUGH PRISONERS"
	
	# show/hide buttons that are needed for fail screen
	next_level_button.visible = false
	retry_level_button.visible = true
	retry_level_button.pressed.connect(Constants.reset_existing_level)
	
	# hide score related UI elements
	global_score.visible = false
	prisoners_saved.visible = false
	

func _updates_for_success() -> void:
	
	# if we finished all the levels, cannot go to next level
	if Constants.does_next_level_exist() == false:
		next_level_button.visible = false
		level_summary_label.text = "Game Complete"	
	else:
		level_summary_label.text = 'LEVEL ' +str(Constants.current_level+1) + ' complete'
		level_message.text = "Good Job"
		next_level_button.visible = true
		next_level_button.pressed.connect( Constants.go_to_next_level )

	retry_level_button.visible = false # cannot retry level when we win

	# scores for level
	global_score.text = 'Score: ' + str(Constants.current_score()).pad_zeros(7)
	prisoners_saved.text = 'Rescued: ' + str(Constants.level_total_prisoners_saved)
