class_name Unit extends CharacterBody2D

@export var unitPower: int

@export var speedMultiplier: int

@export var destination: Vector2

func _init() -> void:
	speedMultiplier = 1
	destination = Vector2(0, 0)

func _physics_process(delta: float) -> void:
	
	if (abs(position - destination) > Vector2(3, 3)):
		velocity = (destination - position).normalized() * speedMultiplier
	else:
		velocity = Vector2.ZERO

	move_and_slide()
