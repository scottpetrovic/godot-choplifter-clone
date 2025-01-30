extends Area2D

@export var _gravity: float = 100.0  # Acceleration due to gravity (pixels/second²)
var gravity_change: float = 0.0

# initial velocity from helicopter when we start
var _initial_x_velocity: float = 0

func _ready():
	add_to_group("PlayerBullet")
	area_entered.connect(_on_area_entered)
	body_entered.connect(_body_entered)
	
	# add player helicopter velocity to nudge bomb in direction
	_initial_x_velocity = Constants.player_reference.velocity.x * 0.03

func _process(delta):
	# Apply gravity
	gravity_change += _gravity * delta

	# Update position
	global_position.y += gravity_change * delta
	global_position.x += _initial_x_velocity
	
	global_rotation_degrees += delta * -40
	

func _body_entered(_body: Node2D) -> void:

	# cannot collide with player
	if _body == Constants.player_reference:
		return
		
	Constants.spawn_explosion(global_position)
	queue_free()

func _on_area_entered(area: Area2D):
	
	Constants.spawn_explosion(global_position)
	
	# do damage to area if it can be hurt
	if area.has_method("hit"):
		area.hit(5)
	
	# Handle collision with target area
	# You can add explosion effects, damage calculation, or other logic here
	queue_free()  # Remove the bomb from the scene
