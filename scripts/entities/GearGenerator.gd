extends Sprite2D

@export var gearsPerInterval = 1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	ResourceManager.addResource(ResourceManager.ResourceNames.GEARS,gearsPerInterval)

func destroy():
	$Damageable.get_overlapping_areas()
	queue_free()
