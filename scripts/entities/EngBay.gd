class_name EngBay extends Sprite2D

@export var researchLength: int
@export var enabled = false
var doneResearch: bool=false

var timeElapsed: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timeElapsed = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if enabled:
		timeElapsed += delta
		doneResearch = timeElapsed >= researchLength
