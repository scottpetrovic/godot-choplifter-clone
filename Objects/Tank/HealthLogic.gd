extends Area2D

@export var health: int = 25
@export var points_when_destroyed = 200

func _ready() -> void:
	get_parent().add_to_group("Enemy")
	area_entered.connect(_area_enter)


func hit(damage: int = 1):
	health -= damage
	
	# enemy death
	if health <= 0:
		Constants.spawn_explosion(global_position)
		Constants.add_to_score(points_when_destroyed)
		GlobalAudio.play_sfx_explosion()
		Constants.spawn_bonus_star_on_chance(global_position)
		queue_free()


func _area_enter(_area: Area2D) -> void:
	if _area.is_in_group("PlayerBullet"):
		hit(1)
		
