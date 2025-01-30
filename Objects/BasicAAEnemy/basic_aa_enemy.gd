class_name BasicAAEnemy
extends Area2D

# start by just following character with gun to get that lined up

# only do this when in range
@onready var gun: Node2D = $Gun
@export var lookout_range: int = 100

var health: int = 3

func _ready() -> void:
	add_to_group("Enemy")

	area_entered.connect(_area_enter)


func hit(damage: int = 1):
	health -= damage
	
	# enemy death
	if health <= 0:
		Constants.spawn_explosion(global_position)
		Constants.level_score += 20
		queue_free()


func _area_enter(_area: Area2D) -> void:
	if _area.is_in_group("PlayerBullet"):
		hit(1)
		


func _process(_delta: float) -> void:
	
	# logic with when enemy will start following player based on distance
	if is_player_in_range():
		_follow_player('snap')

func is_player_in_range() -> bool:
	var distance_to_player: float = global_position.distance_to(Constants.player_reference.global_position)
	if distance_to_player < lookout_range:
		return true
		
	return false
	

func _follow_player(type: String) -> void:
	# follow very precisley
	if type == 'precise':
		gun.look_at(Constants.player_reference.global_position)
		gun.rotation += PI / 2
	
	# follow in increments of 45 degrees
	if type == 'snap':
		var angle = (Constants.player_reference.global_position - global_position).angle()
		var degrees = rad_to_deg(angle)
		var snapped_degrees = round(degrees / 45.0) * 45.0
		gun.rotation = deg_to_rad(snapped_degrees) 
		gun.rotation += PI/2 # fix for 2D sprites to align
	
