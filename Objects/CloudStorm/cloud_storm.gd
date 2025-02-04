extends Area2D

@onready var attack_cooldown_timer: Timer = $AttackCooldownTimer
var cooldown_between_attacks: int = 3.0

func _ready():
	body_entered.connect(_body_enter)
	
	attack_cooldown_timer.one_shot = true
	attack_cooldown_timer.stop()

func _body_enter(_body) -> void:
	if _body == Constants.player_reference && attack_cooldown_timer.is_stopped():
		Constants.player_reference.hit()
		# start timer cooldown before we hurt the player again
		attack_cooldown_timer.start(cooldown_between_attacks)
		
