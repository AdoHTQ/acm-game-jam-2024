class_name DirectionalSprite extends AnimatedSprite2D

func playAnimation(name: String) -> void:
	if (animation == name): return
	playAnimation(name)

func _process(delta: float) -> void:
	pass;
