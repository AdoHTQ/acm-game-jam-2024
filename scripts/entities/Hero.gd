class_name Hero extends CharacterBody2D

var potentialItems = []
var currentItems : Array[ItemBase]
@onready var Items = $Items
@export var currentExperience = 0
var currentLevel = 1
var experienceThreshold:int = 100
@export var moveSpeed: float
@export var directions: Array[Area2D] = []
@export var closeArea: Area2D
@export var midArea: Area2D
@export var outerArea: Area2D

@export var damageMultiplier : float = 1.0
@export var attackSpeedMultiplier : float = 1.0
@export var moveSpeedMultiplier : float = 1.0
@export var damageTakenMultiplier : float = 1.0
@export var healthMultiplier : float = 1.0

var heroLevel: int = 1

var moveDirection: Vector2 = Vector2.ZERO

signal levelUp


func _ready() -> void:
	potentialItems.append(MotorOil)
	potentialItems.append(ItemBase)
func _physics_process(delta):
	
	
	
	velocity = moveDirection * moveSpeed * moveSpeedMultiplier
	move_and_slide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func move():
	var directionSum: Vector2 = Vector2.ZERO
	
	for i: int in range(4):
		var area: Area2D = directions[i]
		var unitSum = 0
		for unit: Unit in area.get_overlapping_bodies():
			unitSum += unit.unitPower
		
		if (unitSum == 0): continue
		
		var direction: float = (PI/4) + (PI/2) * i
		direction *= 1 if heroLevel * 10 < unitSum else -1
		directionSum += Vector2.from_angle(direction)
	
	moveDirection = directionSum.normalized()
	
	if midArea.get_overlapping_bodies().size() > 0:
		moveDirection = Vector2.ZERO
	
	if closeArea.get_overlapping_bodies().size() > 0:
		var minDistUnit: Unit = closeArea.get_overlapping_bodies()[0]
		var minDist = closeArea.get_overlapping_bodies()[0].position.distance_squared_to(position)
		for unit: Unit in closeArea.get_overlapping_bodies():
			if (unit.position.distance_squared_to(position) < minDist): minDistUnit = unit
		
		moveDirection = (position - minDistUnit.position).normalized()


func _on_level_check_timer_timeout() -> void:
	if currentExperience >= experienceThreshold:
		levelUp.emit()
		currentExperience -= experienceThreshold
		experienceThreshold *= 1.3
		currentLevel += 1
		var temp = potentialItems[randi_range(0, potentialItems.size()-1)]
		if temp in currentItems:
			print("Upgraded!")
			potentialItems[currentItems.find(temp)].upgrade()
		Items.add_child(temp.new())
		
