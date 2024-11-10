class_name Unit extends CharacterBody2D

@export var unitPower: int

@export var speedMultiplier: int

@export var destination: Vector2

var currentHitbox

func _init() -> void:
	speedMultiplier = 1
	destination = position

func _physics_process(delta: float) -> void:
	
	if (abs(position - destination) > Vector2(3, 3)):
		velocity = (destination - position).normalized() * speedMultiplier
	else:
		velocity = Vector2.ZERO

	move_and_slide()
	




func _on_damageable_body_entered(body: Node2D) -> void:
	if not body is Unit and body.has_method("damage"):
		body.damage(20)
		await get_tree().create_timer(1).timeout
