extends AnimatedSprite2D

@onready var prisoner: Prisoner = $".."


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	
	if is_instance_valid(prisoner) == false:
		return
	
	# update animation
	if prisoner.prisoner_state() == Constants.PrisonerBehaviorState.IDLE:
		play("idle")
	else:
		play("walk")
	
	update_direction_facing()


func update_direction_facing() -> void:
	if prisoner.facing_direction() == Constants.PrisonerDirection.RIGHT:
		flip_h = false
	else:
		flip_h = true
