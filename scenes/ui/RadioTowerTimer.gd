extends Label

func _physics_process(delta: float) -> void:
	var tower: RadTower = get_node_or_null("/root/Factory/Buildings/RadTower")
	if tower == null: return
	
	text = "Space Laser In:\n" + str(tower.timer.time_left)
