extends Button



func _on_pressed() -> void:
	ResourceManager.addResource(ResourceManager.ResourceNames.GEARS, 20)
	get_tree().change_scene_to_file("res://scenes/levels/Factory.tscn")
