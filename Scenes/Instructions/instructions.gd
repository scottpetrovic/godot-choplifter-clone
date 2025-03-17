extends Control

@onready var more_text_display: Node2D = $MoreTextDisplay
@onready var active_text_area: Label = $ActiveTextArea
var active_text_index: int = 0

var jungle_text_screens: Array[String] = [
	"Welcome to the elite team of pilots.",
	"I am commander MIHKAIL. It is time to put",
	"your training to good use.",
	"Save as many hostages as possible. Return",
	"to base in your helicopter. If you die with",
	"hostages in your helicopter, those hostages ",
	"will die as well.",
	"Now for controls in case you need refreshing",
	"Double tap directions to switch shooting",
	"directions. Hostages will come out to you", 
	"when you destroy a door."	
	]
	
var ocean_text_screens: Array[String] = [
	"You did a great job clearing out that jungle",
	"Next, we need assistance on the sea helping",
	"soldiers stranded at sea."
]

var city_text_screens: Array[String] = [
	"This is an urgent message...",
	"The enemy has ambushed us and we need",
	"your help. Come quick!"
]

# this will change depending on the level/stage we are in
var active_text_screens: Array[String] = []

func _ready() -> void:
	_select_active_stage_data()
	_change_to_screen(0)
	GlobalAudio.play_title_music()


func _select_active_stage_data() -> void:
	# text will be different depending on which stage/environment
	match Constants.current_environment_stage:
		Constants.EnvironmentStage.JUNGLE:
			active_text_screens = jungle_text_screens
		Constants.EnvironmentStage.OCEAN:
			active_text_screens = ocean_text_screens
		Constants.EnvironmentStage.CITY:
			active_text_screens = city_text_screens


func _change_to_screen(screen_idx: int) -> void:
	active_text_index = screen_idx
	
	# if we our index is past the last one, that means we go to the next scene
	if active_text_index >= active_text_screens.size():
		Constants.go_to_world_map()
		return

	active_text_area.text = active_text_screens[active_text_index]
	active_text_area.visible_ratio = 0.0


func _process(delta: float) -> void:
	
	# slowly reveal text screen if it isn't revealed
	if active_text_area.visible_ratio < 1.0:
		active_text_area.visible_ratio += delta * 0.3
	
	# if we haven't shown all the text, shoot will display everything
	# otherwise we will go to the next screen
	if Input.is_action_just_pressed("shoot"):
		
		if active_text_area.visible_ratio < 1.0:
			active_text_area.visible_ratio = 1.0
		else:
			_change_to_screen(active_text_index+1)



func is_text_done_displaying() -> bool:
	return active_text_area.visible_ratio == 1.0
