extends Node2D

@onready var path_follow_2d: PathFollow2D = $Path2D/PathFollow2D
@onready var camera_2d: Camera2D = $Camera2D

var _ending_progress_ratio: float = 0.0

enum HelicopterWorldState { TAKEOFF, FLY, LAND }
var _movement_state: HelicopterWorldState = HelicopterWorldState.TAKEOFF

@onready var helicopter_sprite: Node2D = $Path2D/PathFollow2D/Helicopter
@onready var helicopter_propellers: Sprite2D = $"Path2D/PathFollow2D/Helicopter/Helicopter-top-propellers"


var ground_helicopter_ground_scale: Vector2 = Vector2(0.7, 0.7)
var liftoff_speed: float = 0.1

func go_to_environment_1() -> void:
	# city to jungle: environment 1
	# 0 -> 0.367
	path_follow_2d.progress_ratio = 0.0 # starting
	_ending_progress_ratio = 0.367

func go_to_environment_2() -> void:
	# jungle to sea base: environment 2
	# 0.36 -> 0.748
	path_follow_2d.progress_ratio = 0.367 # starting
	_ending_progress_ratio = 0.748
	
func go_to_environment_3() -> void:
	# sea base to city: environment 3
	# 0.748 -> 1.0
	path_follow_2d.progress_ratio = 0.748 # starting
	_ending_progress_ratio = 1.0


func _ready() -> void:
	
	# simulate being landed because it is smaller
	helicopter_sprite.scale = ground_helicopter_ground_scale
	
	# TODO: This will be set based on our current level from globals
	# if we just got done with level 3, play the environment 2
	# if we just got done with level 6, play the environment 3
	go_to_environment_1()
	#go_to_environment_2()
	#go_to_environment_3()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	# always spin helicopter propeller
	helicopter_propellers.rotation_degrees += delta*1000
	
	match _movement_state:
		HelicopterWorldState.TAKEOFF:
			_takeoff(delta)
		HelicopterWorldState.FLY:
			_fly_to_destination(delta)
		HelicopterWorldState.LAND:
			_land(delta)
			

func _land(delta: float) -> void:
	# grow to simulate being in the air
	if helicopter_sprite.scale > ground_helicopter_ground_scale:
		helicopter_sprite.scale = helicopter_sprite.scale.move_toward( ground_helicopter_ground_scale, delta*liftoff_speed )
		return
	
	# landed go to next scene
	Constants.start_first_level()
	#print('landed, go to next scene')


func _takeoff(delta: float) -> void:
	
	# grow to simulate being in the air
	if helicopter_sprite.scale < Vector2(1.0, 1.0):
		helicopter_sprite.scale = helicopter_sprite.scale.move_toward( Vector2(1.0, 1.0), delta*liftoff_speed )
		return
	
	# we have taken off, proceed to next state
	_movement_state = HelicopterWorldState.FLY


func _fly_to_destination(delta: float) -> void:
	# slowly move progress ratio until we get to the end
	if path_follow_2d.progress_ratio < _ending_progress_ratio:
		path_follow_2d.progress_ratio += delta * 0.05
		return
		
	# we have taken off, proceed to next state
	_movement_state = HelicopterWorldState.LAND
