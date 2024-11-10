extends ItemBase
class_name GearThrower

var hero: Hero

var gear: PackedScene = preload("res://scenes/entities/GearProjectile.tscn")

func _ready() -> void:
	hero = get_parent().get_parent()
	upgrade()

func upgrade():
	var timer: SceneTreeTimer = get_tree().create_timer(1.)
	#timer.timeout.connect(attack)

#func attack():
	#
