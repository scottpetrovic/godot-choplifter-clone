extends Node

@export var lookout_range: int = 100
@export var is_tank_shooting: bool = true

@onready var gun: Node2D = $"../Gun"


func _process(_delta: float) -> void:
	
	# logic with when enemy will start following player based on distance
	if is_player_in_range():
		_follow_player('snap')
	else:
		# rotate gun at "resting" position when player not in range
		# magic value looked about right
		if is_tank_shooting:
			gun.rotation_degrees = 85


func is_player_in_range() -> bool:
	var distance_to_player: float = get_parent().global_position.distance_to(Constants.player_reference.global_position)
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
		var angle = (Constants.player_reference.global_position - get_parent().global_position).angle()
		var degrees = rad_to_deg(angle)
		var snapped_degrees = round(degrees / 45.0) * 45.0
		
		# when snapped, can only fire at 45 degree angles
		# tanks cannot fire straight up
		if is_tank_shooting:
			if snapped_degrees == -45 || snapped_degrees == -135:
				gun.rotation = deg_to_rad(snapped_degrees) 
				gun.rotation += PI/2 # fix for 2D sprites to align			
		else:
			if snapped_degrees == -45 || snapped_degrees == -90 || snapped_degrees == -135:
				gun.rotation = deg_to_rad(snapped_degrees) 
				gun.rotation += PI/2 # fix for 2D sprites to align
