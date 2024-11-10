class_name Damageable extends Area2D

@export var health: int
@export var animator: AnimationPlayer

func damage(damage: int) -> void:
	health -= damage
	#health = health if health >= 0 else 0
	
	if health <= 0: animator.play("death")
