extends Node2D

var isPlacing : bool
@onready var holder = preload("res://scenes/entities/GearGenerator.tscn")
@onready var instance = holder.instantiate()

@onready var temp = holder.instantiate()
# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	instance.visible = false
	add_child(instance)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	#temp.position = get_global_mouse_position()
	if isPlacing:
		instance.position = get_global_mouse_position()
	
	if Input.is_action_just_pressed("confirm") and isPlacing:
		if ResourceManager.spendResource(ResourceManager.ResourceNames.GEARS,0):
			if not (instance.get_node(instance.get_path() as String + "/Damageable").get_overlapping_areas().size()):
				var newThing = holder.instantiate()
				newThing.set_position(get_global_mouse_position())
				add_child(newThing)
			
	



func _on_button_pressed() -> void:
	isPlacing = true
