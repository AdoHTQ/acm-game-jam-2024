extends Camera2D

var cameraSpeed : float
var zoomSpeed : float
var mouseDown : bool
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _unhandled_input(event: InputEvent) -> void:
	if (event is InputEventMouseButton):
		var button : InputEventMouseButton = event as InputEventMouseButton
		mouseDown = button.button_index == MOUSE_BUTTON_MIDDLE && button.pressed
		
		
		zoom.x = clamp(zoom.x - zoomSpeed * (button.button_index == 1 if MOUSE_BUTTON_WHEEL_UP else 0 as float), 0.001,100 )
		zoom.y = clamp(zoom.y - zoomSpeed * button.button_index == 1 if MOUSE_BUTTON_WHEEL_UP else 0, 0.001,100 )
		zoom.x = clamp(zoom.x + zoomSpeed * button.button_index == 1 if MOUSE_BUTTON_WHEEL_DOWN else 0, 0.001,100 )
		zoom.y = clamp(zoom.y + zoomSpeed * button.button_index == 1 if MOUSE_BUTTON_WHEEL_DOWN else 0, 0.001,100 )
	if (event is InputEventMouseMotion and mouseDown):
		var motion : InputEventMouseMotion = event as InputEventMouseMotion
		position += Vector2(motion.relative.x, motion.relative.y) * cameraSpeed
