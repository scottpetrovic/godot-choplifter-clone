extends Area2D


# TODO: This is a bonus star that will start with an upward
# velocity and slowly come down, and fall out of screen
# when if falls out of the screen, it can queue_free()
# If the player interacts with this, it will give the 
# player 50% health and add 200 points to the score 
@export var _initial_velocity: float = -45.0  # Negative value for upward movement
@export var _gravity: float = 14.0
@export var _health_bonus: float = .5  # 50% health bonus
@export var _score_bonus: int = 200

var velocity: Vector2 = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	velocity = Vector2(0, _initial_velocity)
	body_entered.connect(_on_body_entered)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	velocity.y += _gravity * delta # Apply gravity to vertical velocity
	position += velocity * delta # Update position
	
	# Check if star has fallen below the screen
	if position.y > get_viewport_rect().size.y + 50:  # Add some buffer
		queue_free()
	
# Handle collision with player
func _on_body_entered(body: Node2D) -> void:
	if body == Constants.player_reference:
		# Add health to player (assuming player has a health property)
		if body.has_method("heal"):
			body.heal(_health_bonus)
		
		# Add score (assuming there's a GameManager or similar with add_score method)
		Constants.add_to_score(200)		
		GlobalAudio.play_sfx_level_up()

		queue_free() # Remove the star
