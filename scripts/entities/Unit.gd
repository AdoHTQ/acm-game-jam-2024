class_name Unit extends CharacterBody2D

@export var speedMultiplier: int

@export var unitSpeed: Vector2
@export var unitPosition: Vector2
@export var destination: Vector2

func _init(
	_speedMultiplier: int=1,
	_unitSpeed: Vector2=Vector2(0, 0),
	_unitPosition: Vector2=Vector2(0, 0),
	_destination: Vector2=Vector2(0, 0)
) -> void:
	speedMultiplier = _speedMultiplier
	unitSpeed = _unitSpeed
	unitPosition = _unitPosition
	destination = _destination

func _physics_process(delta: float) -> void:
	
	unitSpeed = (destination - unitPosition).normalized() * speedMultiplier

	velocity.x = unitSpeed.x
	velocity.y = unitSpeed.y

	move_and_slide()
