extends ItemBase
class_name Turbocharger

var hero: Hero

func _ready() -> void:
	hero = get_parent().get_parent()
	upgrade()

func upgrade():
	hero.attackSpeedMultiplier += 0.2
