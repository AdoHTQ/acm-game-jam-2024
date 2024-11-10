class_name RectDraw extends Node2D

@export var shape: UnitController

func _draw():
	draw_rect(
		shape.rectToDraw,
		Color(0.4, 1.0, 0.4, 0.4),
		true
	)
	draw_rect(
		shape.rectToDraw,
		Color(0.4, 1.0, 0.4, 0.9),
		false,
		3
	)

func _process(delta: float) -> void:
	queue_redraw()
