extends ItemBase
class_name GearThrower

var hero: Hero

var gear: PackedScene = preload("res://scenes/entities/GearProjectile.tscn")

func _ready() -> void:
	hero = get_parent().get_parent()
	upgrade()

func upgrade():
	get_tree().create_timer(1.).timeout.connect(attack)


func attack():
	if hero.outerArea.get_overlapping_bodies().size() > 0:
		var minDistUnit: Unit = hero.outerArea.get_overlapping_bodies()[0]
		var minDist = hero.outerArea.get_overlapping_bodies()[0].position.distance_squared_to(position)
		for unit: Unit in hero.outerArea.get_overlapping_bodies():
			if (unit.position.distance_squared_to(position) < minDist): minDistUnit = unit
	
		var instance: Projectile = gear.instantiate()
		instance.position = hero.position
		instance.direction = instance.position.direction_to(minDistUnit.position)
		instance.damage *= hero.damageMultiplier
		get_tree().root.add_child(instance)
	
	get_tree().create_timer(1.).timeout.connect(attack)
