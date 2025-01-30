extends Node2D

@onready var door: Area2D = $Door
@onready var door_rect: ColorRect = $Door/ColorRect
@onready var prisoner_release_timer: Timer = $Door/PrisonerReleaseTimer

const PRISONER = preload("res://Objects/Prisoner/prisoner.tscn")

var _is_door_destroyed: bool = false

@export var prisoners_held_captive: int = 4

# how close does player need to be for prisoners to come out
var _distance_to_run_to_player: int = 80 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	door.area_entered.connect(_area_enter)
	
	# prisoners come out at a staggered pace
	prisoner_release_timer.wait_time = 1.0
	prisoner_release_timer.one_shot = true
	

func _area_enter(_area: Area2D) -> void:

	if _area.is_in_group("PlayerBullet") && _is_door_destroyed == false:
		_is_door_destroyed = true
		door_rect.modulate = "#000000"
		Constants.spawn_explosion(global_position)


func _process(_delta: float) -> void:
	
	# if the door is destroyed, we have prisoners in camp, and player is on the ground
	# we can try to release players
	if _is_door_destroyed && prisoners_held_captive > 0 && Constants.player_reference.is_on_floor():
		_slowly_release_prisoners()



func _slowly_release_prisoners():

	# cannot release a new prisoner if our timer delay is still running
	if prisoner_release_timer.is_stopped() == false:
		return

	# prisoners like it if player is closer to them before coming out
	var dist_to_player = door.global_position.distance_to(Constants.player_reference.global_position)
	if dist_to_player < _distance_to_run_to_player:
		_release_prisoner()

func _release_prisoner() -> void:
	
	# We only want to let prisoners if the timer isn't running
	# if timer is not running, instantiate a prisoner object at 0,0
	# then start the timer
	var pris: Node2D = PRISONER.instantiate()
	add_child(pris)
	prisoner_release_timer.start()
	prisoners_held_captive -= 1
