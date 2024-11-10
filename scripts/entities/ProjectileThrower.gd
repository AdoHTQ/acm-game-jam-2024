class_name ProjectileThrower extends Node2D

var timeSinceLastThrow: float
@export var throwInterval: float
@export var projectileDamage: int

var projectileScene: PackedScene = preload("res://scenes/entities/LightProjectile.tscn")

var hero: Node2D 

func _ready() -> void:
	hero = get_node("/root/Factory/Hero")
	timeSinceLastThrow = 0
	throwInterval = 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	throwInterval = 1
	timeSinceLastThrow += delta
	if timeSinceLastThrow > throwInterval:
		var instance: Projectile = projectileScene.instantiate()

		instance.direction = (hero.position - global_position).normalized()
		instance.position = global_position
		instance.damage = projectileDamage
		
		get_tree().root.add_child(instance)
		timeSinceLastThrow = 0
