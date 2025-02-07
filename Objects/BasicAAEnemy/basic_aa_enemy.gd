class_name BasicAAEnemy
extends Area2D

var health: int = 3

func _ready() -> void:
	add_to_group("Enemy")
	area_entered.connect(_area_enter)


func hit(damage: int = 1):
	health -= damage
	
	# enemy death
	if health <= 0:
		Constants.spawn_explosion(global_position)
		Constants.global_score += 20
		GlobalAudio.play_sfx_explosion()
		queue_free()


func _area_enter(_area: Area2D) -> void:
	if _area.is_in_group("PlayerBullet"):
		hit(1)
		
