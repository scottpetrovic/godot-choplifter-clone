extends Area2D

@export var health: int = 100
@export var points_when_destroyed = 200

func _ready() -> void:
	get_parent().add_to_group("Enemy")
	area_entered.connect(_area_enter)


func hit(damage: int = 1):
	health -= damage
	
	# enemy death
	if health <= 0:
		Constants.spawn_explosion(global_position)
		Constants.global_score += points_when_destroyed
		queue_free()


func _area_enter(_area: Area2D) -> void:
	if _area.is_in_group("PlayerBullet"):
		hit(1)
		
