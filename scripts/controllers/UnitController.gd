class_name UnitController extends Area2D

@export var collisionShape: CollisionShape2D
@export var cam: Camera2D

var inverseOffset: Vector2

var isSelecting: bool

var rectToDraw: Rect2

var topLeftCoords: Vector2
var bottomRightCoords: Vector2

var selectedUnits: Array[Node2D]

func _ready() -> void:
	inverseOffset = Vector2(cam.offset.x, cam.offset.y)

func _init() -> void:
	topLeftCoords = Vector2(0, 0)
	bottomRightCoords = Vector2(0, 0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (isSelecting):
		rectToDraw = Rect2(
			topLeftCoords - position + cam.offset - inverseOffset,
			(get_viewport().get_mouse_position() - topLeftCoords)
		)
	else:
		rectToDraw = Rect2(-999999, -999999, 0, 0)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		# this handles selecting a new group of units
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				topLeftCoords = event.position
				isSelecting = true
			else:
				isSelecting = false
				bottomRightCoords = event.position
				position = ((topLeftCoords + bottomRightCoords) / 2) + cam.offset - inverseOffset
				(collisionShape.shape as RectangleShape2D).extents = (bottomRightCoords - topLeftCoords) / 2
			
				# the casting here might not work as expected, if we have issues check this ASAP
				selectedUnits = get_overlapping_bodies()

		# this handles rallying units to the position of the mouse
		if event.button_index == MOUSE_BUTTON_RIGHT:
			# only check for the press so we don't get double commands
			if event.pressed:
				for unit in selectedUnits:
					unit.destination = event.position + cam.offset - inverseOffset
				
			
