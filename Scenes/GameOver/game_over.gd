extends Control

@onready var retry_button: Button = $VBoxContainer/RetryButton
@onready var main_menu_button: Button = $VBoxContainer/MainMenuButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	retry_button.pressed.connect(retry_click)
	main_menu_button.pressed.connect(main_menu_click)


func retry_click() -> void:
	Constants.reset_existing_level()
	
func main_menu_click() -> void:
	Constants.go_to_main_menu()
