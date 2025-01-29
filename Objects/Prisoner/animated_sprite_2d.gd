extends AnimatedSprite2D

@onready var prisoner: Prisoner = $".."


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	# update animation
	if prisoner.prisoner_state == prisoner.PrisonerBehaviorState.IDLE:
		play("idle")
	else:
		play("walk")
	
	update_direction_facing()


func update_direction_facing() -> void:
	if prisoner.prisoner_facing_direction == prisoner.PrisonerDirection.RIGHT:
		flip_h = false
	else:
		flip_h = true
