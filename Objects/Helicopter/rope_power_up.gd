extends Area2D

var is_rope_colliding_with_something: bool = false
@onready var sprite: ColorRect = $Sprite
@onready var helicopter_player: HelicopterPlayer = $".."


func _ready() -> void:
	
	# test by giving us the power up by default
	Constants.level_active_powerup = Constants.PowerUpType.ROPE
	
	body_entered.connect(_body_enter)
	body_exited.connect(_body_exit)
	
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
	
	if Constants.level_active_powerup != Constants.PowerUpType.ROPE:
		return #exit out of process if we don't have a rope powerup

	# add a bit of rotation to the rope, regardless of state
	if helicopter_player.velocity.x < 0:
		rotation_degrees = move_toward(rotation_degrees,-20, delta*20)
	elif helicopter_player.velocity.x > 0:
		rotation_degrees = move_toward(rotation_degrees,20, delta*20)
	else:
		rotation_degrees = move_toward(rotation_degrees,0, delta*20)

	# if we are not going to hit something while extending
	# the rope, extend it when we press the button
	if Input.is_action_pressed("shoot_special") && \
		is_rope_colliding_with_something == false:
		_try_to_drop_rope_if_not()
	else:
		_bring_in_rope_if_not()


func _try_to_drop_rope_if_not() -> void:
	sprite.visible = true


func _bring_in_rope_if_not() -> void:
	sprite.visible = false
