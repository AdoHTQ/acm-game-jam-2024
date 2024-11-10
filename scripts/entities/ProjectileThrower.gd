class_name ProjectileThrower extends Node2D

var timeSinceLastThrow: float
@export var throwInterval: float

@export var projectileScene: PackedScene

var hero: Node2D 

func _ready() -> void:
	hero = get_node("/root/Factory/Hero")
	timeSinceLastThrow = 0
	throwInterval = 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timeSinceLastThrow += delta
	print(timeSinceLastThrow)
	if timeSinceLastThrow > throwInterval:
		print("ablls")
		timeSinceLastThrow = 0

		var instance: Projectile = projectileScene.instantiate()

		instance.direction = hero.position - global_position
		
		get_tree().root.add_child(instance)
