class_name UnitController extends Area2D

@export var collisionShape: CollisionShape2D
@export var cam: Camera2D

var hero: Hero

var inverseOffset: Vector2

var isSelecting: bool
var startChecking: bool
var timeAfterStart: float

var rectToDraw: Rect2

var topLeftCoords: Vector2
var bottomRightCoords: Vector2

var selectedUnits: Array[Node2D]

func _ready() -> void:
	inverseOffset = Vector2(cam.offset.x, cam.offset.y)
	body_shape_entered.connect(_body_shape_entered)
	hero = get_node("/root/Factory/Hero")

func _init() -> void:
	topLeftCoords = Vector2(0, 0)
	bottomRightCoords = Vector2(0, 0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (isSelecting):
		rectToDraw = Rect2(
			topLeftCoords - position + cam.offset - inverseOffset / cam.zoom,
			(get_viewport().get_mouse_position() / cam.zoom - topLeftCoords)
		)
	else:
		rectToDraw = Rect2(-999999, -999999, 0, 0)
	
	# this is to stop checking for entities in the selection area after half a second
	# I know its really dank, I don't like it either
	if startChecking:
		timeAfterStart += delta
		if timeAfterStart > 0.25:
			position = Vector2(-99999, -99999)
			startChecking = false
			timeAfterStart = 0
	
	

func _body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int):
	selectedUnits.append(body)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		# this handles selecting a new group of units
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				topLeftCoords = event.position / cam.zoom
				isSelecting = true
			else:
				selectedUnits.clear()
				bottomRightCoords = event.position / cam.zoom
				position = ((topLeftCoords + bottomRightCoords) / 2 ) + cam.offset - inverseOffset / cam.zoom
				(collisionShape.shape as RectangleShape2D).extents = (bottomRightCoords - topLeftCoords if bottomRightCoords > topLeftCoords else topLeftCoords - bottomRightCoords) / 2

				isSelecting = false
				startChecking = true

		# this handles rallying units to the position of the mouse
		elif event.button_index == MOUSE_BUTTON_RIGHT:
			# only check for the press so we don't get double commands
			if event.pressed:
				var dest: Vector2
				var heroLock: bool
				if abs(hero.position - (event.position / cam.zoom + cam.offset - inverseOffset / cam.zoom)).length() < hero.midArea.get_child(0).shape.radius:
					dest = hero.position
					heroLock = true
				else:
					dest = event.position / cam.zoom + cam.offset - inverseOffset / cam.zoom
					heroLock = false
					
				for unit in selectedUnits:
					unit.destination = dest
					unit.lock_hero(heroLock)
