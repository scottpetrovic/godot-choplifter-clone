extends Sprite2D

func _ready():
	start_blinking()

func start_blinking():
	while true:
		visible = true # Visible for 1 second
		await get_tree().create_timer(0.5).timeout

		visible = false  # Invisible for 0.5 seconds
		await get_tree().create_timer(4.5).timeout
