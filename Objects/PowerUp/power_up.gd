extends Area2D


# if player collides, make active powerup

# specify in export variable what type of powerup it is?
@export var power_up_type: Constants.PowerUpType = Constants.PowerUpType.BOMBS
@onready var label: Label = $Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(_body_enter)
	
	if power_up_type == Constants.PowerUpType.BOMBS:
		label.text = "B"
	elif power_up_type == Constants.PowerUpType.ROPE:
		label.text = "R"
	
func _body_enter(_body: Node2D) -> void:
	if _body == Constants.player_reference:
		Constants.level_active_powerup = power_up_type
		queue_free()
