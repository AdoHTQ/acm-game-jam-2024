extends Node

enum ResourceNames {BONES}

var resourceCounts : Array = []

func _init() -> void:
	resourceCounts.resize(ResourceNames.size())
	for i: int in ResourceNames.values():
		resourceCounts[i] = 0;

func addResource(resource : int, amount : int) -> void:
	resourceCounts[resource] += amount

func spendResource(resource : int, cost : int) -> bool:
	if (resourceCounts[resource] < cost): return false
	resourceCounts[resource] -= cost
	return true
