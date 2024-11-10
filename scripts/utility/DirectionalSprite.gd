class_name DirectionalSprite extends AnimatedSprite2D

@export var mirrorMode: bool = false

func playAnimation(name: String) -> void:
	if (animation == name): return
	playAnimation(name)

func _ready() -> void:
	play()

func _process(delta: float) -> void:
	var parent: CharacterBody2D = get_parent()
	var velocity: Vector2 = parent.velocity
	
	if mirrorMode:
		animation = "walk" if velocity.length() > 0 else "idle"
		flip_h = velocity.x < 0
