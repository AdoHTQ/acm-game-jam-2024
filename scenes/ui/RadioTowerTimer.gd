extends Label

func _physics_process(delta: float) -> void:
	var tower: RadTower = get_node_or_null("/root/Factory/RadTower")
	if tower == null: return
	if tower.timer.is_stopped(): return
	text = "Space Laser In:\n%2.2f" % tower.timer.time_left
