extends ItemBase
class_name Sledgehammer

var hero: Hero

func _ready() -> void:
	hero = get_parent().get_parent()
	upgrade()

func upgrade():
	hero.damageMultiplier += 0.2
