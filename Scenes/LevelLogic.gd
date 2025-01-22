extends Node2D

func _ready():
	await get_tree().process_frame # make sure all children loaded
	var total_prisoners: int = _caculate_total_prisoners_for_level()
	Constants.level_total_remaining_prisoners = total_prisoners

func _caculate_total_prisoners_for_level() -> int:
	var prisoner_camps: Array[Node] = get_tree().get_nodes_in_group("PrisonerCamp")
	
	var total_initial_prisoners = 0
	for camp in prisoner_camps:
		total_initial_prisoners += camp.prisoners_held_captive
		
	return total_initial_prisoners
