extends Control

@onready var screen_1: Control = $Screen1
@onready var screen_2: Control = $Screen2
@onready var screen_3: Control = $Screen3

func _ready() -> void:
		screen_1.visible = true
		screen_2.visible = false
		screen_3.visible = false

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("shoot"):
		go_to_next_screen()

func go_to_next_screen() -> void:
	
	print('go to next screen')
	# go to screen 2
	if screen_1.visible:
		screen_1.visible = false
		screen_2.visible = true
		screen_3.visible = false
		return

	# go to screen 3
	if screen_2.visible:
		screen_1.visible = false
		screen_2.visible = false
		screen_3.visible = true
		return
		
	if screen_3.visible:
		Constants.start_new_game()
