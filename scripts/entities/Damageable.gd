class_name Damageable extends Area2D

@export var health: int

func damage(damage: int) -> void:
	health -= damage
	health = health if health >= 0 else 0
	print("CAN I PUT MY BALLS IN YO JAW")
