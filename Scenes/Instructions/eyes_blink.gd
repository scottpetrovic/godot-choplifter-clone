extends Sprite2D

var blink_timer: float = 0.0
var is_visible_phase: bool = true
const VISIBLE_DURATION: float = 0.5
const INVISIBLE_DURATION: float = 4.5

func _ready() -> void:
	visible = true

func _process(delta: float) -> void:
	blink_timer += delta
	
	if is_visible_phase:
		if blink_timer >= VISIBLE_DURATION:
			visible = false
			blink_timer = 0.0
			is_visible_phase = false
	else:
		if blink_timer >= INVISIBLE_DURATION:
			visible = true
			blink_timer = 0.0
			is_visible_phase = true
