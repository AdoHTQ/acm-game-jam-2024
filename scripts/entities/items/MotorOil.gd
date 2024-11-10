extends ItemBase

var hero: Hero

func _ready() -> void:
	hero = get_parent().get_parent()
	hero.moveSpeedMultiplier += 0.2

func upgrade():
	hero.moveSpeedMultiplier += 0.2
