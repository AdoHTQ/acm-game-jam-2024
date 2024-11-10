extends Node2D

var isPlacing : bool
@onready var holder = preload("res://scenes/entities/GearGenerator.tscn")
@onready var lightMelee = preload("res://scenes/entities/LightMelee.tscn")
@onready var instance = null

var lowBuildLeft : int = 10 
var medBuildLeft : int = 10 
var highBuildLeft : int = 10 

var currentCounterLabel = null # Just for making the building limited supply label work.
# Called when the node enters the scene tree for the first time.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#temp.position = get_global_mouse_position()
	if isPlacing:
		instance.position = get_global_mouse_position()
	
	if Input.is_action_just_pressed("confirm") and isPlacing:
		if ResourceManager.spendResource(ResourceManager.ResourceNames.GEARS,0):
			if not (instance.get_node(instance.get_path() as String + "/Damageable").get_overlapping_areas().size()):
				print("Hi!")
				if currentCounterLabel != null:
					lowBuildLeft -= 1
					currentCounterLabel.text = str(lowBuildLeft) + " Left"
				isPlacing = false
				instance = null
			
	

func _on_low_building_button_pressed() -> void:# The cheapest and worst genertor
	if lowBuildLeft > 0:
		isPlacing = true
		instance = holder.instantiate()
		add_child(instance)
		currentCounterLabel = $CanvasLayer/UnitScene/MarginContainer2/Units/HBoxContainer/Building1/Control/Label2
	
func _on_light_melee_button_pressed() -> void:# The cheapest and worst genertor
	if isPlacing == true:
		remove_child(instance)
		currentCounterLabel = null
	isPlacing = true
	instance = lightMelee.instantiate()
	add_child(instance)
	
	
