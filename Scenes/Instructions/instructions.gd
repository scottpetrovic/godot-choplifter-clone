extends Control

@onready var more_text_display: Node2D = $MoreTextDisplay
@onready var active_text_area: Label = $ActiveTextArea
var active_text_index: int = 0



var text_screens: Array[String] = [
	"WELCOME TO THE ELITE TEAM OF PILOTS PRIVATE. I AM COMMANDER MIKHAIL. IT IS TIME TO PUT YOUR TRAINING TO GOOD USE...",
	"SAVE AS MANY HOSTAGES AS POSSIBLE AND RETURN TO BASE IN YOUR HELICOPTER. IF YOU DIE WITH HOSTAGES IN YOUR HELICOPTER,THOSE HOSTAGES WILL DIE AS WELL...",
	"DOUBLE TAP DIRECTION KEYS TO SWITCH SHOOTING DIRECTION. HOSTAGES  WILL COME OUT TO YOU WHEN YOU DESTROY A DOOR."	
	]

func _ready() -> void:
	_change_to_screen(0)

func _change_to_screen(screen_idx: int) -> void:
	active_text_index = screen_idx
	
	# if we our index is past the last one, that means we go to the next scene
	if active_text_index >= text_screens.size():
		Constants.go_to_world_map()
		return
	
	active_text_area.text = text_screens[active_text_index]
	active_text_area.visible_ratio = 0.0

func _process(delta: float) -> void:
	
	# slowly reveal text screen if it isn't revealed
	if active_text_area.visible_ratio < 1.0:
		active_text_area.visible_ratio += delta * 0.3
	
	if Input.is_action_just_pressed("shoot"):
		_change_to_screen(active_text_index+1)
		
	


func is_text_done_displaying() -> bool:
	return active_text_area.visible_ratio == 1.0
