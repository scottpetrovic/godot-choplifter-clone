extends Control

@onready var health_bar: Sprite2D = $HealthBar

var health_bar_starting_width: float = 0
var player_reference: HelicopterPlayer = null

func _ready() -> void:
	player_reference = Constants.player_reference
	health_bar_starting_width = health_bar.region_rect.size.x


func _process(_delta: float) -> void:
	# update the healthbar region's width based of player heatlh
	var health_perc: float = float(player_reference.health) / float(player_reference.max_health)
	health_bar.region_rect.size.x = health_perc * health_bar_starting_width
	
	
