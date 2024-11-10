class_name ProjectileThrower extends Node2D

var timeSinceLastThrow: int
@export var throwInterval: int

@export var projectileScene: PackedScene

func _init() -> void:
	timeSinceLastThrow = 0
	throwInterval = 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timeSinceLastThrow += delta
	if timeSinceLastThrow > throwInterval:
		var instance: Projectile = projectileScene.instantiate()
		var hero: Node2D = get_node("/factory/Hero")
		
		instance.direction = hero.position - global_position
		
		get_tree().root.add_child(instance)
