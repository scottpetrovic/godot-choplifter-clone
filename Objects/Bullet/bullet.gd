class_name Bullet
extends Area2D

@onready var lifetime_timer: Timer = $LifetimeTimer

# either LEFT, DOWN, RIGHT
var _shoot_direction: Constants.PlayerFacingDirection = Constants.PlayerFacingDirection.LEFT
const BULLET_SPEED = 80

const BULLET_IMPACT = preload("res://Objects/BulletImpact/BulletImpact.tscn")

func set_shoot_direction(direc: Constants.PlayerFacingDirection) -> void:
	_shoot_direction = direc

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	add_to_group("PlayerBullet")

	area_entered.connect(_area_entered)
	body_entered.connect(_body_entered)
	
	lifetime_timer.wait_time = 1.0
	lifetime_timer.one_shot = true
	lifetime_timer.timeout.connect( func(): queue_free() )
	lifetime_timer.start()

func _area_entered(area: Area2D) -> void:
	
	if area.is_in_group("Enemy"):
		
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
	match _shoot_direction:
		Constants.PlayerFacingDirection.LEFT:
			position.x -= BULLET_SPEED * delta
			position.y += BULLET_SPEED * delta
		Constants.PlayerFacingDirection.RIGHT:
			position.x += BULLET_SPEED * delta
			position.y += BULLET_SPEED * delta
		Constants.PlayerFacingDirection.DOWN:
			position.y += BULLET_SPEED * delta
