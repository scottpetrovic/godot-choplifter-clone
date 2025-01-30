extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(_body_enter)


func _body_enter(body: Node2D) -> void:
	if body == Constants.player_reference:
		var player: HelicopterPlayer = body
		body.hit(1)
		
		Constants.level_score += 20
		Constants.spawn_explosion(global_position)
		queue_free()
