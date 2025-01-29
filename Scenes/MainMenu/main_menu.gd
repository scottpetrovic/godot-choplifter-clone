extends Control

@onready var start_button: Button = $VBoxContainer/StartButton

func _ready() -> void:
	start_button.pressed.connect(_start_game)

func _start_game() -> void:
	Constants.start_new_game()
