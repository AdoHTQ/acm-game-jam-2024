extends Sprite2D
class_name RadTower

@export var enabled = false

@export var timer: Timer

func _ready() -> void:
	timer.start()
	timer.paused = true

func _physics_process(delta: float) -> void:
	if enabled and timer.is_stopped():
		timer.paused = false

func win():
	get_tree().change_scene_to_file("res://scenes/ui/Win.tscn")

func lose():
	get_tree().change_scene_to_file("res://scenes/ui/Lose.tscn")
