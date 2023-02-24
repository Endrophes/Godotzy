extends Node2D

# Store Dice
var diceStorage = [];
var rollButton;

# Recursive loop to find all nodes with a specific class
func findAllByClass(node: Node, className : String, result : Array) -> void:
	if node.is_class(className):
		result.push_back(node)
	for child in node.get_children():
		findAllByClass(child, className, result)

# Recursive loop to find all nodes with a specific Name
func findAllByName(node: Node, nodeName : String, result : Array) -> void:
	if node.name.begins_with(nodeName):
		result.push_back(node)
	for child in node.get_children():
		findAllByName(child, nodeName, result)
		
# Recursive loop to find the first node with a specific Name
func findByName(node: Node, nodeName : String, result : Node) -> void:
	if node.name.begins_with(nodeName):
		result = node
		return
	for child in node.get_children():
		findByName(child, nodeName, result)

# Called when the node enters the scene tree for the first time.
func _ready():
	findAllByName(self, "Dice", diceStorage)
#	print(diceStorage)
	rollButton = self.get_node("Roll")
#	print(rollButton)
	rollButton.connect("pressed", self, "_Roll_The_Dice")

func _Roll_The_Dice():
	print("ROLLEN ROLLEN ROLLEN")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
