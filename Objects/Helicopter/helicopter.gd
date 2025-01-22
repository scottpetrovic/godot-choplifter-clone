class_name HelicopterPlayer
extends CharacterBody2D

@export var speed = 80.0

var direction_input: Vector2 = Vector2.ZERO
var prisoners_in_helicopter: int = 0

# helps keeps us on screen mostly so we don't go above screen
var max_elevation: float = 6 # 0 is at the very top of the screen


var max_health: int = 4
var health: int = max_health

func hit() -> void:
	
	if health <= 0:
		return  # we are already dead, no point in taking more damage

	health -= 1
	
	if health <= 0:
		visible = false # hide the player
		_turn_off_collisions()
		EventBus.LevelFailed.emit()

func _turn_off_collisions() -> void:
	process_mode = Node.PROCESS_MODE_DISABLED # stop collisions


func is_alive() -> bool:
	return health > 0

func _init() -> void:
	# allow other objects to reference player in future
	Constants.player_reference = self
	

func _physics_process(_delta):
	
	# we are dead, stop processing input
	if health <= 0: 
		return
	
	# Get input values (-1, 0, or 1 for each axis)
	direction_input = Vector2(
		Input.get_axis("ui_left", "ui_right"),
		Input.get_axis("ui_up", "ui_down")
	)
	
	# if we are at max elevation and trying to go up, just keep level
	if global_position.y <= max_elevation && direction_input.y < 0:
		direction_input.y = 0
	
	# if we are touched down, we cannot move left or right
	if is_on_floor():
		direction_input.x = 0
	
	# Set velocity based on input direction and speed
	velocity = direction_input * speed
	
	# Apply the movement
	move_and_slide()
	
