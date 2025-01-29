extends Control

@onready var level_win_label: Label = $LevelWinLabel

@onready var next_level_button: Button = $VBoxContainer/NextLevelButton
@onready var main_menu_button: Button = $VBoxContainer/MainMenuButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	level_win_label.text = 'LEVEL ' +str(Constants.current_level+1) + ' COMPLETE'
	next_level_button.pressed.connect(next_level_click)
	main_menu_button.pressed.connect(main_menu_click)
	

func next_level_click() -> void:
	print('go to next level now')


func main_menu_click() -> void:
	Constants.go_to_main_menu()
