extends ItemBase

var hero: Hero

func _ready() -> void:
	hero = get_parent().get_parent()
