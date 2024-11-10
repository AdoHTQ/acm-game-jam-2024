class_name DirectionalSprite extends AnimatedSprite2D

@export var mirrorMode: bool = false

var oneshotting: bool = false

func _ready() -> void:
	play()

func _process(delta: float) -> void:
	if oneshotting: return
	var parent: CharacterBody2D = get_parent()
	var velocity: Vector2 = parent.velocity
	
	if mirrorMode:
		animation = "walk" if velocity.length() > 0 else "idle"
		if velocity.x < 0: flip_h = true
		if velocity.x > 0: flip_h = false
	else:
		if velocity.length() > 0:
			animation = "walk_" + ("l" if velocity.x < 0 else "r")
		else:
			animation = "idle"

func attack():
	var parent: CharacterBody2D = get_parent()
	oneshot("attack_" + ("l" if parent.velocity.x < 0 else "r"))

func oneshot(anim: String):
	play(anim)
	oneshotting = true

func anim_done():
	oneshotting = false
