extends Button

@export var scene: String

func press():
	get_tree().change_scene_to_file(scene)
