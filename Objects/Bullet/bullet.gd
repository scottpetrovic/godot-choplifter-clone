class_name Bullet
extends Area2D

@onready var lifetime_timer: Timer = $LifetimeTimer

# either LEFT, DOWN, RIGHT
var _shoot_direction: Constants.PlayerFacingDirection = Constants.PlayerFacingDirection.LEFT
const BULLET_SPEED = 130

const BULLET_IMPACT = preload("res://Objects/BulletImpact/BulletImpact.tscn")

# take it in from player
var starting_velocity_x: float = 0.0

func set_shoot_direction(direc: Constants.PlayerFacingDirection) -> void:
	_shoot_direction = direc

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	# add a bit of player's velocity to bullet to go opposite direction
	starting_velocity_x = Constants.player_reference.velocity.x
	
	add_to_group("PlayerBullet")

	area_entered.connect(_area_entered)
	body_entered.connect(_body_entered)
	
	lifetime_timer.wait_time = 1.0
	lifetime_timer.one_shot = true
	lifetime_timer.timeout.connect( func(): queue_free() )
	lifetime_timer.start()

func _area_entered(area: Area2D) -> void:
	
	if area.is_in_group("Enemy") || area.is_in_group("Prisoner"):
		
		if area.has_method("hit"):
			area.hit(1)
			
		create_bullet_impact(global_position)
		queue_free()

func create_bullet_impact(pos: Vector2) -> void:
	var impact = BULLET_IMPACT.instantiate()
	get_tree().current_scene.add_child(impact)
	impact.global_position = pos

func _body_entered(body: Node2D) -> void:
	
	# player bullet cannot hurt ourself
	if body == Constants.player_reference:
		return

	create_bullet_impact(global_position)
	
	# probably hit the ground rigid body
	queue_free()

func _process(delta: float) -> void:
	
	var side_fall_strength: float = 0.5
	match _shoot_direction:
		Constants.PlayerFacingDirection.LEFT:
			position.x -= (BULLET_SPEED - starting_velocity_x) * delta 
			position.y += BULLET_SPEED * delta * side_fall_strength
		Constants.PlayerFacingDirection.RIGHT:
			position.x += (BULLET_SPEED + starting_velocity_x) * delta
			position.y += BULLET_SPEED * delta * side_fall_strength
		Constants.PlayerFacingDirection.DOWN:
			position.y += BULLET_SPEED * delta
