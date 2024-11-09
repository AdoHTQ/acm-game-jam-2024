class_name Unit extends CharacterBody2D

@export var speedMultiplier: int

@export var unitSpeed: Vector2
@export var unitPosition: Vector2
@export var destination: Vector2

func _init() -> void:
	speedMultiplier = 1
	unitSpeed = Vector2(0, 0)
	unitPosition = Vector2(0, 0)
	destination = Vector2(0, 0)

func _physics_process(delta: float) -> void:
	
	unitSpeed = (destination - unitPosition).normalized() * speedMultiplier

	velocity.x = unitSpeed.x
	velocity.y = unitSpeed.y

	move_and_slide()
