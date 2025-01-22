extends Node

var bullet_scene: PackedScene = preload("res://Objects/Bullet/Bullet.tscn")

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("shoot"):
		shoot()

func shoot() -> void:
	var bullet: Bullet = bullet_scene.instantiate()
	bullet.set_shoot_direction(Constants.player_direction)
	get_tree().current_scene.add_child(bullet)
	bullet.global_position = Constants.player_reference.global_position
