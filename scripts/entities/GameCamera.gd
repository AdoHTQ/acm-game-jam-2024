extends Camera2D

var zoomTarget: Vector2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	zoomTarget = zoom


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var moveVector := Vector2.ZERO
	if Input.is_action_just_pressed("zoom_in"):
		zoomTarget *= 1.1
	if Input.is_action_just_pressed("zoom_out"):
		zoomTarget *= 0.9
	
	if Input.is_action_pressed("pan_right"):
		moveVector.x += 1500
	if Input.is_action_pressed("pan_left"):
		moveVector.x -= 1500
	if Input.is_action_pressed("pan_up"):
		moveVector.y -= 1500
	if Input.is_action_pressed("pan_down"):
		moveVector.y += 1500
	offset += moveVector.normalized() * delta * 1500
	zoom = zoom.slerp(zoomTarget,1)
	
