class_name UnitPlacer extends Node2D

var isPlacing : bool
var costLowMult : float = 1 
var costMedMult : float = 1 

var currentCostMult : float = 1

@onready var gearGen = preload("res://scenes/entities/GearGenerator.tscn")
@onready var engBay = preload("res://scenes/entities/EngBay.tscn")
@onready var radTower = preload("res://scenes/entities/RadTower.tscn")
@onready var lightMelee = preload("res://scenes/entities/LightMelee.tscn")
@onready var lightGunner = preload("res://scenes/entities/LightGunner.tscn")
@onready var heavyMelee = preload("res://scenes/entities/HeavyMelee.tscn")
@onready var heavyGunner = preload("res://scenes/entities/HeavyGunner.tscn")
@onready var unitPlaceSound = preload("res://assets/audio/sound/place_unit.wav")
@onready var buildingPlaceSound = preload("res://assets/audio/sound/place_building.wav")
@onready var instance = null
@export var soundPlayer: AudioStreamPlayer
enum Level {NONE,LOW,MED,HIGH}
var engBays: Array[EngBay]
var lowBuildLeft : int = 10 
var medBuildLeft : int = 2 
var highBuildLeft : int = 1 
var tmp : Level = Level.NONE
var currentCounterLabel = null # Just for making the building limited supply label work.
var currentCostLabel = null

var popup: AcceptDialog

func _ready() -> void:
	popup = get_node("/root/Factory/NotificationPopup")
	popup.hide()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#temp.position = get_global_mouse_position()
	
	if instance == null: return
	
	if isPlacing:
		instance.position = get_global_mouse_position()
	
	if Input.is_action_just_pressed("confirm") and isPlacing:
		if ResourceManager.resourceCounts[ResourceManager.ResourceNames.GEARS] >= (instance.get_node("Cost").cost * currentCostMult) as int:
			if not (instance.get_node(instance.get_path() as String + "/Damageable").get_overlapping_areas().size()):
				soundPlayer.stream = buildingPlaceSound
				soundPlayer.play()
				ResourceManager.spendResource(ResourceManager.ResourceNames.GEARS, (instance.get_node("Cost").cost * currentCostMult) as int)
				instance.get_node(instance.get_path() as String + "/Damageable").enabled = true
				instance.enabled = true
				match tmp:
					Level.NONE:
						var newCopy = instance.duplicate()
						
						add_child(newCopy)
						if newCopy.get_node_or_null(newCopy.get_path() as String + "/ProjectileThrower"):
							newCopy.get_node(newCopy.get_path() as String + "/ProjectileThrower").enabled = true
						
					Level.LOW:
						
						costLowMult += 0.6+ costLowMult * 0.6
						lowBuildLeft -= 1
						currentCounterLabel.text = str(lowBuildLeft) + " Left"
						currentCostLabel.text = "Factory\n" + str((instance.get_node("Cost").cost * costLowMult) as int) + " gears"
						instance = null
						isPlacing = false
					Level.MED:
						costMedMult += 0.8 + costMedMult * 0.8
						medBuildLeft -= 1
						currentCounterLabel.text = str(medBuildLeft) + " Left"
						currentCostLabel.text = "Engineering\nBay\n" + str((instance.get_node("Cost").cost * costLowMult) as int) + " gears"
						engBays.append(instance)
						instance = null
						isPlacing = false
					Level.HIGH:
						highBuildLeft -= 1
						currentCounterLabel.text = str(highBuildLeft) + " Left"
						instance = null
						isPlacing = false

				
				
				
				
		else:
			popup.dialog_text = "You don't have enough gears to make that! :P"
			popup.title = "Not Enough Gears!"
			popup.popup()
	elif Input.is_action_just_pressed("deselect"): 
		isPlacing = false
		instance.queue_free()
		instance = null
	

func _on_low_building_button_pressed() -> void:# The cheapest and worst genertor
	if isPlacing: return
	currentCostMult = costLowMult
	if lowBuildLeft > 0:
		isPlacing = true
		instance = gearGen.instantiate()
		add_child(instance)
		instance.get_node(instance.get_path() as String + "/Damageable").enabled = false
		currentCounterLabel = $CanvasLayer/UnitScene/MarginContainer2/Units/HBoxContainer/Building1/Control/Label2
		currentCostLabel = $CanvasLayer/UnitScene/MarginContainer2/Units/HBoxContainer/Building1/Control/Label
		tmp = Level.LOW
	else:
		popup.dialog_text = "You've reached the limit of Factories!"
		popup.title = "Building Limit Reached!"
		popup.popup()
		
func _on_med_building_button_pressed() -> void:
	if isPlacing: return
	currentCostMult = costMedMult
	if medBuildLeft > 0:
		isPlacing = true
		instance = engBay.instantiate()
		add_child(instance)
		instance.get_node(instance.get_path() as String + "/Damageable").enabled = false
		currentCounterLabel = $CanvasLayer/UnitScene/MarginContainer2/Units/HBoxContainer/Building2/Control/Label2
		currentCostLabel = $CanvasLayer/UnitScene/MarginContainer2/Units/HBoxContainer/Building2/Control/Label
		tmp = Level.MED
	else:
		popup.dialog_text = "You've reached the limit of Engineering Bays!"
		popup.title = "Building Limit Reached!"
		popup.popup()
		
func _on_high_building_button_pressed() -> void:
	if isPlacing: return
	var canBuild = false
	for bay in engBays:
		if bay.doneResearch:
			canBuild = true
			break
	if highBuildLeft > 0 and canBuild:
		isPlacing = true
		instance = radTower.instantiate()
		add_child(instance)
		instance.get_node(instance.get_path() as String + "/Damageable").enabled = false
		currentCounterLabel = $CanvasLayer/UnitScene/MarginContainer2/Units/HBoxContainer/Building3/Control/Label2
		tmp = Level.HIGH
	else:
		if not canBuild:
			popup.dialog_text = "Build an Engineering Bay to unlock this building!"
			popup.title = "Not Enough Research!"
		else:
			popup.dialog_text = "You've reached the limit of Radio Towers!"
			popup.title = "Building Limit Reached!"
		popup.popup()
	
func _on_light_melee_button_pressed() -> void:# The cheapest and worst genertor
	tmp = Level.NONE
	currentCostMult = 1
	if isPlacing == true:
		remove_child(instance)
		currentCounterLabel = null
	isPlacing = true
	instance = lightMelee.instantiate()
	
	add_child(instance)
	instance.get_node(instance.get_path() as String + "/Damageable").enabled = false
	
func _on_light_gunner_button_pressed() -> void:
	tmp = Level.NONE
	currentCostMult = 1
	if isPlacing == true:
		remove_child(instance)
		currentCounterLabel = null
	isPlacing = true
	instance = lightGunner.instantiate()
	
	add_child(instance)
	instance.get_node(instance.get_path() as String + "/Damageable").enabled = false
	instance.get_node(instance.get_path() as String + "/ProjectileThrower").enabled = false
	
func _on_heavy_melee_button_pressed() -> void:# The cheapest and worst genertor
	tmp = Level.NONE
	currentCostMult = 1
	if isPlacing == true:
		remove_child(instance)
		currentCounterLabel = null
	isPlacing = true
	instance = heavyMelee.instantiate()
	
	add_child(instance)
	instance.get_node(instance.get_path() as String + "/Damageable").enabled = false
func _on_heavy_gunner_button_pressed() -> void:
	tmp = Level.NONE
	currentCostMult = 1
	if isPlacing == true:
		remove_child(instance)
		currentCounterLabel = null
	isPlacing = true
	instance = heavyGunner.instantiate()
	
	add_child(instance)
	instance.get_node(instance.get_path() as String + "/Damageable").enabled = false
	instance.get_node(instance.get_path() as String + "/ProjectileThrower").enabled = false
