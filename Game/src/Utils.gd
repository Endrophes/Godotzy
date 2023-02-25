# This script contains some extra code that I like and wanted to save for later

# Recursive loop to find all nodes with a specific Name
#EX: findAllThatIncludeName(self, "Dice", diceStorage)
func findAllThatIncludeName(node: Node, nodeName : String, result : Array) -> void:
	if node.name.begins_with(nodeName):
		result.push_back(node)
	for child in node.get_children():
		findAllThatIncludeName(child, nodeName, result)

