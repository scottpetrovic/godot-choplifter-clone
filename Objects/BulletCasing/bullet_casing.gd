extends ColorRect

var velocity: Vector2 = Vector2(0, 0)  # initial upward and leftward velocity
var gravity: float = 300  # adjust gravity as needed
var timer: float = 0


func _ready() -> void:
	
	var starting_up_velocity: float = -80.0
	velocity.y = starting_up_velocity
	
	# get direction of helicopter to eject casing opposite direciton
	if Constants.player_reference.facing_direction() == Constants.PlayerFacingDirection.LEFT:
		velocity.x = 60
	else:
		velocity.x = -60

func _process(delta: float):
	# apply gravity
	velocity.y += gravity * delta
	
	# move bullet casing to ground
	position += velocity * delta
	
	# track lifetime and remove ourself after X seconds
	timer += delta
	if timer >= 3:
		queue_free()
