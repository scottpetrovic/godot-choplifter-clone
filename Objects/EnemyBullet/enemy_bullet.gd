class_name EnemyBullet
extends Area2D

@onready var lifetime_timer: Timer = $LifetimeTimer
const BULLET_SPEED = 50

var _rotation: float = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	add_to_group("EnemyBullet")
	
	body_entered.connect(_body_entered)
	
	lifetime_timer.wait_time = 1.5
	lifetime_timer.one_shot = true
	lifetime_timer.timeout.connect( func(): queue_free() )
	lifetime_timer.start()


func _body_entered(body: Node2D) -> void:
	
	#print(body.name)
	if body.has_method("hit"):
		body.hit()
	
	queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# just shoot straight locally. We should already be rotated
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * BULLET_SPEED * delta
	pass
