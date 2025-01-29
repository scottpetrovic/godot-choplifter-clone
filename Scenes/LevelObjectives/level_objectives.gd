extends VBoxContainer

@onready var current_level: Label = $CurrentLevel
@onready var lives_left: Label = $LivesLeft
@onready var prisoners_left: Label = $PrisonersLeft

@onready var next_scene_timer: Timer = $"../NextSceneTimer"

@onready var level_objectives: CanvasLayer = $".."



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	level_objectives.visible = true
	next_scene_timer.wait_time = 3.0
	next_scene_timer.timeout.connect( func(): level_objectives.visible = false )
	next_scene_timer.start()
	
func show_screen_on_level_fail() -> void:
	level_objectives.visible = true
	next_scene_timer.start()


func _process(_delta: float) -> void:
	current_level.text = 'LEVEL ' + str(Constants.current_level+1)
	lives_left.text = str(Constants.lives_left) + ' x LIVES'
	prisoners_left.text = str(Constants.level_total_remaining_prisoners) + ' x PRISONERS'
	
