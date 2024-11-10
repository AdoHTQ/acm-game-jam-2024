extends ItemBase
class_name RepairPack

var hero: Hero

func _ready() -> void:
	hero = get_parent().get_parent()
	upgrade()

func upgrade():
	hero.healingDelay -= 5
