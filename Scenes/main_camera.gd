extends Camera2D

@export var target_path: NodePath
@export var smooth_speed: float = 5.0

var target: Node2D
var initial_vertical_position: float
@onready var shake = $CameraShake  # Reference to the shake node

func _ready():
	if target_path:
		target = get_node(target_path)
		
	# Store the initial vertical position of the camera
	# this will lock the camera vertically
	# so we can only go side to side
	initial_vertical_position = global_position.y
	
func _process(delta: float) -> void:
	_update_offset(delta)
	
func _update_offset(delta: float) -> void:
	# lerp the offset depending on what direction the player is facing
	# if we are facing right, we want to see more of the screen to the left for example
	var anim_delta = delta * 3
	var target_offset = Vector2.ZERO
	
	if Constants.player_reference:
		if Constants.player_reference.facing_direction() == Constants.PlayerFacingDirection.LEFT:
			target_offset.x = -40
			target_offset.y = 0
		elif Constants.player_reference.facing_direction() == Constants.PlayerFacingDirection.RIGHT:
			target_offset.x = 40
			target_offset.y = 0
		
		# Lerp the base offset
		offset.x = lerpf(offset.x, target_offset.x, anim_delta)
		offset.y = lerpf(offset.y, target_offset.y, anim_delta)
		
		# Add shake if it exists
		if shake && shake.current_shake != Vector2(0, 0):
			offset += shake.current_shake

func _physics_process(delta):
	if target:
		
		# if our vertical position is in the ground level range, we will lock 
		# the camera
		
		var low_point_lock: int = 120 
		var high_point_lock: int = 20 
		if target.global_position.y > high_point_lock && target.global_position.y < low_point_lock:
			var target_position = Vector2(target.global_position.x, initial_vertical_position)
			global_position = global_position.lerp(target_position, smooth_speed * delta)
			return
			
		# Smoothly move camera but only on x axis
		global_position = global_position.lerp(target.global_position, smooth_speed * delta)
