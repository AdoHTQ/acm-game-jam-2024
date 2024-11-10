class_name DirectionalSprite extends AnimatedSprite2D

@export var mirrorMode: bool = false

func _ready() -> void:
	play()

func _process(delta: float) -> void:
	var parent: CharacterBody2D = get_parent()
	var velocity: Vector2 = parent.velocity
	
	if mirrorMode:
		animation = "walk" if velocity.length() > 0 else "idle"
		if velocity.x < 0: flip_h = true
		if velocity.x > 0: flip_h = false
	else:
		if velocity.length() > 0:
			animation = "walk_" + ("l" if velocity.x < 0 else "r")
			print(animation)
		else:
			animation = "idle"
