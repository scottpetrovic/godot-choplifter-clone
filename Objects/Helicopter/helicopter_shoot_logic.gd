extends Node

var bullet_scene: PackedScene = preload("res://Objects/Bullet/Bullet.tscn")
const PLAYER_BOMB: PackedScene = preload("res://Objects/BombPlayer/PlayerBomb.tscn")

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("shoot"):
		shoot()
	if Input.is_action_just_pressed("shoot_bomb") && \
		Constants.level_active_powerup == Constants.PowerUpType.BOMBS:
		drop_bomb()

func drop_bomb():
	var _bomb = PLAYER_BOMB.instantiate()
	get_tree().current_scene.add_child(_bomb)
	_bomb.global_position = Constants.player_reference.global_position

func shoot() -> void:
	var bullet: Bullet = bullet_scene.instantiate()
	bullet.set_shoot_direction(Constants.player_direction)
	get_tree().current_scene.add_child(bullet)
	bullet.global_position = Constants.player_reference.global_position
