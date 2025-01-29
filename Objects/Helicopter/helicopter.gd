class_name HelicopterPlayer
extends CharacterBody2D

@export var speed = 80.0

var direction_input: Vector2 = Vector2.ZERO
var prisoners_in_helicopter: int = 0

# helps keeps us on screen mostly so we don't go above screen
#var max_elevation: float = 20 # 0 is at the very top of the screen

var max_health: int = 4
var health: int = max_health

# for resetting player when/if we die
var _starting_position: Vector2 = Vector2.ZERO

# disable movement once level is over/complete
var enable_movement: bool = true

func hit(damage: int = 1) -> void:
	
	if health <= 0:
		return  # we are already dead, no point in taking more damage

	health -= damage
	
	if health <= 0:
		visible = false # hide the player
		EventBus.LevelFailed.emit()


func reset_player_after_loss() -> void:
	visible = true
	enable_movement = true
	global_position = _starting_position
	health = max_health
	Constants.level_active_powerup = Constants.PowerUpType.NONE
	prisoners_in_helicopter = 0 # they died in the helicopter if they existed

func is_alive() -> bool:
	return health > 0

func _ready() -> void:
	# allow other objects to reference player in future
	Constants.player_reference = self
	_starting_position = global_position
	
	EventBus.LevelComplete.connect(_level_complete)
	EventBus.LevelFailed.connect(_level_fail)

func facing_direction() -> Constants.PlayerFacingDirection:
	return $HelicopterDirectionLogic.get_direction()
	
func set_facing_direction(direc: Constants.PlayerFacingDirection) -> void:
	$HelicopterDirectionLogic.set_direction(direc)

func _level_complete() -> void:
	enable_movement = false
	
func _level_fail() -> void:
	enable_movement = false

func _physics_process(_delta):
	
	# we are dead, or level is over. stop processing input
	if health <= 0 || enable_movement == false: 
		return
	
	# Get input values (-1, 0, or 1 for each axis)
	direction_input = Vector2(
		Input.get_axis("ui_left", "ui_right"),
		Input.get_axis("ui_up", "ui_down")
	)

	# if we are touched down, we cannot move left or right
	if is_on_floor():
		direction_input.x = 0
	
	# Set velocity based on input direction and speed
	velocity = direction_input * speed
	
	# Apply the movement
	move_and_slide()
	
