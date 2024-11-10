extends Sprite2D

@export var gearsPerInterval = 1
@export var enabled = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	if enabled:
		ResourceManager.addResource(ResourceManager.ResourceNames.GEARS,gearsPerInterval)

func destroy():
	$Damageable.get_overlapping_areas() # no idea what this does lmao
	queue_free()
