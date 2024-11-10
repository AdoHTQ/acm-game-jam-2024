extends Node2D

var isPlacing : bool
var holder = preload("res://scenes/entities/GearGenerator.tscn")
var temp
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	temp = holder.instantiate()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("confirm"):
		#if ResourceManager.spendResource(ResourceManager.ResourceNames.GEARS,-1):
		temp.position = get_global_mouse_position()



func _on_button_pressed() -> void:
	isPlacing = true
