extends VBoxContainer

@onready var current_level: Label = $CurrentLevel
@onready var lives_left: Label = $LivesLeft
@onready var prisoners_required: Label = $PrisonersRequired


@onready var level_objectives: CanvasLayer = $".."

func _ready() -> void:
	level_objectives.visible = true
	
	# don't allow player to move/shoot while objectives
	# screen is on
	Constants.player_reference.enable_movement = false


func show_screen_on_level_fail() -> void:
	level_objectives.visible = true


func _process(_delta: float) -> void:
	current_level.text = 'LEVEL ' + str(Constants.current_level+1)
	lives_left.text = ' x ' + str(Constants.lives_left).pad_zeros(2)
	
	var min_prisoners = Constants.level_min_prisoners_to_success
	prisoners_required.text = ' x ' + str(min_prisoners).pad_zeros(2)
	
	if Input.is_action_just_pressed("shoot"):
		level_objectives.visible = false
		
		# player can start moving and shooting now
		Constants.player_reference.enable_movement = true
		
