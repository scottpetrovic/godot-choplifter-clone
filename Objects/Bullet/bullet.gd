class_name Bullet
extends Area2D

# either LEFT, DOWN, RIGHT
var _shoot_direction: Constants.PlayerFacingDirection = Constants.PlayerFacingDirection.LEFT
@onready var lifetime_timer: Timer = $LifetimeTimer

const BULLET_SPEED = 80

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
		queue_free()
	
func _body_entered(body: Node2D) -> void:
	pass
	#print('body entered ' + body.name)

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
