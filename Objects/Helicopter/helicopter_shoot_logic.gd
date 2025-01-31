extends Node

var bullet_scene: PackedScene = preload("res://Objects/Bullet/Bullet.tscn")
const PLAYER_BOMB: PackedScene = preload("res://Objects/BombPlayer/PlayerBomb.tscn")

@onready var bullet_timer: Timer = $BulletTimer
@onready var bomb_timer: Timer = $BombTimer

func _ready() -> void:
	# Set the timer wait times
	bullet_timer.wait_time = 0.2  # seconds between shots
	bomb_timer.wait_time = 1.5    # seconds between bombs
	
	# Make sure they're configured as one-shot timers
	bullet_timer.one_shot = true
	bomb_timer.one_shot = true

func _process(_delta: float) -> void:
	
	# level is over stop, shooting
	if Constants.player_reference.enable_movement == false:
		return
	
	# Handle shooting
	if Input.is_action_just_pressed("shoot") and not bullet_timer.time_left:
		shoot()
		bullet_timer.start()
	
	# Handle bombing
	if Input.is_action_just_pressed("shoot_bomb") and \
		Constants.level_active_powerup == Constants.PowerUpType.BOMBS and \
		not bomb_timer.time_left:
		drop_bomb()
		bomb_timer.start()

func drop_bomb():
	var _bomb = PLAYER_BOMB.instantiate()
	get_tree().current_scene.add_child(_bomb)
	_bomb.global_position = Constants.player_reference.global_position

func shoot() -> void:
	Constants.add_camera_shake(0.2)
	var bullet: Bullet = bullet_scene.instantiate()
	bullet.set_shoot_direction(Constants.player_reference.facing_direction())
	get_tree().current_scene.add_child(bullet)
	bullet.global_position = Constants.player_reference.global_position
