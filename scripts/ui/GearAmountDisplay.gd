extends Control

func _on_timer_timeout() -> void:
	$Panel/Label.text = "Gears: " + str(ResourceManager.resourceCounts[ResourceManager.ResourceNames.GEARS])
