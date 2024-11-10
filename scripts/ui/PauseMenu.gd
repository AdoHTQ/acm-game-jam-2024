extends Control



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		if visible == false: 
			get_tree().paused = true
			visible = true
		else:
			get_tree().paused = false
			visible = false


func _on_resume_pressed() -> void:
	get_tree().paused = false
	visible = false


func on_settings_pressed() -> void:
		pass # Replace with function body.


func _on_quit_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/ui/MainMenu.tscn")


func on_quit_pressed() -> void:
	get_tree().quit()
