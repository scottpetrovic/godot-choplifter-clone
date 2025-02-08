extends Polygon2D

@onready var instructions: Control = $"../.."
@onready var more_text_display: Node2D = $".."


func _process(delta: float) -> void:
	if instructions.is_text_done_displaying():
		more_text_display.visible = true
	else:
		more_text_display.visible = false

func _ready():
	start_blinking()

func start_blinking():
	while true:
		visible = true # Visible for 1 second
		await get_tree().create_timer(1.0).timeout

		visible = false  # Invisible for 0.5 seconds
		await get_tree().create_timer(0.5).timeout
