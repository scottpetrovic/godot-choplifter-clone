class_name EnemyBullet
extends Area2D

@onready var lifetime_timer: Timer = $LifetimeTimer
const BULLET_SPEED = 120
const GRAVITY = 180  # Adjust this value to control gravity strength
var velocity: Vector2

func _ready() -> void:
	add_to_group("EnemyBullet")
	body_entered.connect(_body_entered)
	
	lifetime_timer.wait_time = 1.0
	lifetime_timer.one_shot = true
	lifetime_timer.timeout.connect(func(): queue_free())
	lifetime_timer.start()
	
	# Initialize the velocity based on rotation and speed
	velocity = Vector2.RIGHT.rotated(rotation) * BULLET_SPEED

func _body_entered(body: Node2D) -> void:
	if body.has_method("hit"):
		body.hit()
	queue_free()

func _process(delta: float) -> void:
	# Apply gravity to the velocity
	velocity.y += GRAVITY * delta
	
	# Move the bullet using the velocity
	position += velocity * delta
