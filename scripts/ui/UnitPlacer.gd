class_name UnitPlacer extends Node2D

var isPlacing : bool
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
		if ResourceManager.resourceCounts[ResourceManager.ResourceNames.GEARS] >= instance.get_node("Cost").cost:
			if not (instance.get_node(instance.get_path() as String + "/Damageable").get_overlapping_areas().size()):
				soundPlayer.stream = buildingPlaceSound
				soundPlayer.play()
				ResourceManager.spendResource(ResourceManager.ResourceNames.GEARS, instance.get_node("Cost").cost)
				instance.get_node(instance.get_path() as String + "/Damageable").enabled = true
				match tmp:
					Level.LOW:
						lowBuildLeft -= 1
						currentCounterLabel.text = str(lowBuildLeft) + " Left"
					Level.MED:
						medBuildLeft -= 1
						currentCounterLabel.text = str(medBuildLeft) + " Left"
						engBays.append(instance)
					Level.HIGH:
						highBuildLeft -= 1
						currentCounterLabel.text = str(highBuildLeft) + " Left"
				instance.enabled = true
				
				isPlacing = false
				instance = null
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
	if lowBuildLeft > 0:
		isPlacing = true
		instance = gearGen.instantiate()
		add_child(instance)
		instance.get_node(instance.get_path() as String + "/Damageable").enabled = false
		currentCounterLabel = $CanvasLayer/UnitScene/MarginContainer2/Units/HBoxContainer/Building1/Control/Label2
		tmp = Level.LOW
	else:
		popup.dialog_text = "You've reached the limit of Factories!"
		popup.title = "Building Limit Reached!"
		popup.popup()
		
func _on_med_building_button_pressed() -> void:
	if isPlacing: return
	if medBuildLeft > 0:
		isPlacing = true
		instance = engBay.instantiate()
		add_child(instance)
		instance.get_node(instance.get_path() as String + "/Damageable").enabled = false
		currentCounterLabel = $CanvasLayer/UnitScene/MarginContainer2/Units/HBoxContainer/Building2/Control/Label2
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
	
	if isPlacing == true:
		remove_child(instance)
		currentCounterLabel = null
	isPlacing = true
	instance = lightMelee.instantiate()
	
	add_child(instance)
	instance.get_node(instance.get_path() as String + "/Damageable").enabled = false
	
func _on_light_gunner_button_pressed() -> void:
	tmp = Level.NONE
	if isPlacing == true:
		remove_child(instance)
		currentCounterLabel = null
	isPlacing = true
	instance = lightGunner.instantiate()
	
	add_child(instance)
	instance.get_node(instance.get_path() as String + "/Damageable").enabled = false
	
func _on_heavy_melee_button_pressed() -> void:# The cheapest and worst genertor
	tmp = Level.NONE
	if isPlacing == true:
		remove_child(instance)
		currentCounterLabel = null
	isPlacing = true
	instance = heavyMelee.instantiate()
	
	add_child(instance)
	instance.get_node(instance.get_path() as String + "/Damageable").enabled = false
func _on_heavy_gunner_button_pressed() -> void:
	tmp = Level.NONE
	if isPlacing == true:
		remove_child(instance)
		currentCounterLabel = null
	isPlacing = true
	instance = heavyGunner.instantiate()
	
	add_child(instance)
	instance.get_node(instance.get_path() as String + "/Damageable").enabled = false
