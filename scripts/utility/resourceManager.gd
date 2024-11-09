extends Node

# Add entries to add more resources
enum ResourceNames {BONES}

var resourceCounts : Array = []

# Initialize resources array and resets all counts
func _init() -> void:
	resourceCounts.resize(ResourceNames.size())
	resetResources()

# Set all resource amounts to 0
func resetResources() -> void:
	for i: int in ResourceNames.values():
		resourceCounts[i] = 0;

# Add amount to specified resource
func addResource(resource : int, amount : int) -> void:
	resourceCounts[resource] += amount

# Tries to spend given amount of specified resource.
# Resource is only subtracted if you have enough and returns a bool if the purchase was successful.
func spendResource(resource : int, cost : int) -> bool:
	if (resourceCounts[resource] < cost): return false
	resourceCounts[resource] -= cost
	return true
