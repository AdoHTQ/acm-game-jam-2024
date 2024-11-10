extends ItemBase
class_name SteelPlate

var hero: Hero

func _ready() -> void:
	hero = get_parent().get_parent()
	upgrade()

func upgrade():
	hero.maxHealth += 20
