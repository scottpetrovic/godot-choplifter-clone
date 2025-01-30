extends Area2D

var health: int = 4

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("Enemy")
	body_entered.connect(_body_enter)
	area_entered.connect(_area_enter)

func _area_enter(area: Area2D) -> void:
	
	if area.is_in_group("PlayerBullet"):
		hit(1)

func hit(damage: int = 1) -> void:
	health -=1
	
	if health <= 0:
		Constants.level_score += 20
		Constants.spawn_explosion(global_position)
		queue_free()

func _body_enter(body: Node2D) -> void:
	if body == Constants.player_reference:
		var player: HelicopterPlayer = body
		body.hit(1)
		hit(1)
		
		
