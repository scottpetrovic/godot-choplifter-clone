extends Sprite2D


func _ready() -> void:
	# change the background depending on what the environment is
	match Constants.current_environment_stage:
		Constants.EnvironmentStage.JUNGLE:
			texture = load("res://Scenes/LevelObjectives/level-jungle-background.png")
		Constants.EnvironmentStage.OCEAN:
			texture = load("res://Scenes/LevelObjectives/level-ocean-background.png")
		Constants.EnvironmentStage.CITY:
			texture = load("res://Scenes/LevelObjectives/level-city-background.png")
