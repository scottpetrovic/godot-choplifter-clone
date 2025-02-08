extends Area2D

var is_rope_colliding_with_something: bool = false

var helicopter_player: HelicopterPlayer = null
var rotation_amount: float = 30.0
var rotation_speed: float = 40.0
var rope_extend_speed: float = 1.0
	
func _ready() -> void:
	
	# test by giving us the power up by default
	Constants.level_active_powerup = Constants.PowerUpType.ROPE
	
	body_entered.connect(_body_enter)
	body_exited.connect(_body_exit)
	
	area_entered.connect(_area_enter)
	
func _area_enter(_area: Area2D) -> void:
	if _area.is_in_group("Prisoner"):
		_area.climb_ladder()	
	
	
func _body_enter(_body: Node2D) -> void:
	if _body == helicopter_player:
		return # cannot collide with player

	is_rope_colliding_with_something = true
	
func _body_exit(_body) -> void:
	
	if _body == helicopter_player:
		return # cannot collide with player
		
	is_rope_colliding_with_something = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	# player check
	if is_instance_valid(helicopter_player) == false:
		helicopter_player = Constants.player_reference
		return
	
	if Constants.level_active_powerup != Constants.PowerUpType.ROPE:
		self.visible = false
		return #exit out of process if we don't have a rope powerup
	
	self.visible = true

	# add a bit of rotation to the rope, regardless of state

	if helicopter_player.velocity.x < 0:
		rotation_degrees = move_toward(rotation_degrees,-rotation_amount, delta*rotation_speed)
	elif helicopter_player.velocity.x > 0:
		rotation_degrees = move_toward(rotation_degrees,rotation_amount, delta*rotation_speed)
	else:
		rotation_degrees = move_toward(rotation_degrees,0, delta*rotation_speed)

	# if we are not going to hit something while extending
	# the rope, extend it when we press the button
	if Input.is_action_pressed("shoot_special") && \
		is_rope_colliding_with_something == false:
		_try_to_drop_rope_if_not(delta)
	else:
		_bring_in_rope_if_not(delta)

func is_rope_completely_down() -> bool:
	# if we are pressing down the special and our sprite is 
	# all the way expanded, we are all the way out
	return Input.is_action_pressed("shoot_special") && \
		scale.y == 1.0

func _try_to_drop_rope_if_not(delta: float) -> void:
	if scale.y < 1.0:
		scale.y = move_toward(scale.y, 1.0, delta*rope_extend_speed)


func _bring_in_rope_if_not(delta: float) -> void:
	if scale.y > 0.0:
		scale.y = move_toward(scale.y, 0.0, delta*rope_extend_speed)
