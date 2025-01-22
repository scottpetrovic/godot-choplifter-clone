extends Node

var bullet_scene: PackedScene = preload("res://Objects/Bullet/Bullet.tscn")
@onready var helicopter_player: HelicopterPlayer = %Helicopter_Player

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("shoot"):
		shoot()

func shoot() -> void:
	print(helicopter_player.global_position)
	var bullet = bullet_scene.instantiate()
	get_tree().current_scene.add_child(bullet)
	bullet.global_position = helicopter_player.global_position
