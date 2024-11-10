class_name UnitController extends Area2D

@export var collisionShape: CollisionShape2D

var topLeftCoords: Vector2
var bottomRightCoords: Vector2

var selectedUnits: Array[Node2D]

func _init() -> void:
	topLeftCoords = Vector2(0, 0)
	bottomRightCoords = Vector2(0, 0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		# this handles selecting a new group of units
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				print("press at " + event.position)
				topLeftCoords = event.position
			else:
				print("release at " + event.position)
				bottomRightCoords = event.position
				collisionShape.shape.get_rect().position = (topLeftCoords + bottomRightCoords) / 2
				collisionShape.shape.get_rect().size = (bottomRightCoords - topLeftCoords)
			
				# the casting here might not work as expected, if we have issues check this ASAP
				selectedUnits = get_overlapping_bodies()

		# this handles rallying units to the position of the mouse
		if event.button_index == MOUSE_BUTTON_RIGHT:
			# only check for the press so we don't get double commands
			if event.pressed:
				for unit in selectedUnits:
					unit.destination = event.position + global_position
				
			
