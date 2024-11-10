extends Control

var pauseScreen = preload("res://scenes/ui/SettingsMenu.tscn")

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/Factory.tscn")


func _on_settings_pressed() -> void:
	add_child(pauseScreen.instantiate())


func _on_quit_pressed() -> void:
	get_tree().quit()	
