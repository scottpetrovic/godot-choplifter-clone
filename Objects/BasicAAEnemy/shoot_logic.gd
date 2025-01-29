extends Node2D

@onready var shoot_timer: Timer = $ShootTimer
@onready var enemy_base: BasicAAEnemy = $".."
@onready var spawn_point: Marker2D = $SpawnPoint

const ENEMY_BULLET = preload("res://Objects/EnemyBullet/EnemyBullet.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	shoot_timer.wait_time = 2.0
	shoot_timer.one_shot = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if enemy_base.is_player_in_range() && shoot_timer.is_stopped():
		var bull: EnemyBullet = ENEMY_BULLET.instantiate()
		bull.global_position = spawn_point.global_position
		
		# PI/2 is subtracted because our gun faces UP by default
		bull.set_rotation(rotation - PI/2)
		get_tree().current_scene.add_child(bull)
		shoot_timer.start()
