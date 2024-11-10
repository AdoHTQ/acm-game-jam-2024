extends CharacterBody2D

@export var directions: Array[Area2D] = []

var heroLevel: int = 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func move():
	var directionSum: Vector2 = Vector2.ZERO
	
	for i: int in range(4):
		var area: Area2D = directions[i]
		var unitSum = 0
		for unit: Unit in area.get_overlapping_bodies():
			unitSum += unit.unitPower
		
		var direction: float = (PI/4) + (PI/2) * i
		direction *= -1 if heroLevel < unitSum else 1
		directionSum += Vector2.from_angle(direction)
	
	
	
