extends Node2D

# Home base
# this is where the player will start as well as deliver prisoners

@onready var prisoner_release_timer: Timer = $PrisonerReleaseTimer
@onready var door: Area2D = $Door
@onready var helipad: Area2D = $Helipad

const PRISONER = preload("res://Objects/Prisoner/prisoner.tscn")

var _player_on_helipad: bool = false

var finished_collecting_prisoners: bool = false

func _ready() -> void:
	prisoner_release_timer.wait_time = 0.5
	prisoner_release_timer.one_shot = true
	prisoner_release_timer.stop()

	helipad.body_entered.connect(_helipad_enter)
	helipad.body_exited.connect(_helipad_exit)
	
	door.area_entered.connect(_door_enter)
	

func _door_enter(_area: Area2D) -> void:
	if _area.is_in_group("Prisoner"):
		if _area.has_method("returned_to_base"):
			_area.returned_to_base()

func _helipad_enter(body: Node2D) -> void:
	if body == Constants.player_reference:
		_player_on_helipad = true

func _helipad_exit(body: Node2D) -> void:
	if body == Constants.player_reference:
		_player_on_helipad = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	
	# if we are on helipad and we have prisoners to drop off
	# start dropping them off
	if _player_on_helipad && \
		Constants.player_reference.prisoners_in_helicopter > 0:
		_slowly_drop_off_prisoners()

	# we have no more prisoners left... show win message
	if _player_on_helipad && \
		Constants.player_reference.prisoners_in_helicopter == 0 && \
		Constants.level_total_remaining_prisoners == 0:
		
		# make sure this event only fires one time
		if finished_collecting_prisoners == false:
			finished_collecting_prisoners = true
			EventBus.LevelComplete.emit()
			


func _slowly_drop_off_prisoners() -> void:
	# if timer is stopped, it is ok to release another prisoner
	if prisoner_release_timer.is_stopped():
		#create prisoner object and have them head to the right
		var pris = PRISONER.instantiate()
		
		add_child(pris)

		pris.set_objective(Constants.PrisonerObjective.GET_IN_BASE)
		pris.global_position = Constants.player_reference.global_position
		pris.global_position.x += 10
		Constants.player_reference.prisoners_in_helicopter -= 1
		prisoner_release_timer.start()
		
