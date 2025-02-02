extends Area2D
enum ArrowDirection {LEFT, RIGHT}


@onready var blink_timer: Timer = $BlinkTimer
@onready var arrow: Sprite2D = $Arrow

var is_player_in_area: bool = false

func _ready() -> void:
	
	_show_indicator(false)
	
	body_entered.connect(_body_enter)
	body_exited.connect(_body_exit)	

	blink_timer.wait_time = 0.5
	blink_timer.timeout.connect(_on_blink_timer_timeout)
	blink_timer.start()

func _body_enter(_body: Node2D) -> void:
	if _body == Constants.player_reference:
		is_player_in_area = true
		_show_indicator(true)
	
func _body_exit(_body: Node2D) -> void:
	if _body == Constants.player_reference:
		is_player_in_area = false
		_show_indicator(false)

func _show_indicator(_show: bool) -> void:
	arrow.visible = _show
	
func _on_blink_timer_timeout() -> void:
	if is_player_in_area:
		arrow.visible = !arrow.visible
