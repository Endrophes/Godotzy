extends Node2D

# Store Dice
var diceStorage = [];
var valueStorage = {};
var rollButton;
var score = 0;

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
	print(diceStorage)
	rollButton = self.get_node("Roll")
#	print(rollButton)
	rollButton.connect("pressed", self, "_Roll_The_Dice")
	
	get_node("ScoreDisplay").text = str(score);
	
	_reset();

func _reset():
	valueStorage = {
		1 : 0,
		2 : 0,
		3 : 0,
		4 : 0,
		5 : 0,
		6 : 0
	};
	return;

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

# Rolls all the dice
func _Roll_The_Dice():
#	print("ROLLEN ROLLEN ROLLEN")
	
	for die in diceStorage:
		die._roll();
		score += die._getValue();
		valueStorage[die._getValue()] += 1;
	
	print(valueStorage);
	
	get_node("ScoreDisplay").text = str(score);
	_checkPattern();

# Determines the dice pattern based on the dice face
func _checkPattern():
	var dicePattern = "None";
	
	if _IsLargeStraight():
		dicePattern = "Large Straight";
	elif _IsSmallStraight():
		dicePattern = "Small Straight";
	elif _IsFullHouse():
		dicePattern = "Full House";
	elif _IsGodotzy():
		dicePattern = "GODOTZY!";
	elif _IsFourOfAKind():
		dicePattern = "4 of a kind";
	elif _IsThreeOfAKind():
		dicePattern = "3 of a kind";
	elif _IsTwoOfAKind():
		dicePattern = "2 of a kind";
	
	get_node("PatternDisplay").text = dicePattern;
	
	_reset();
	
	return;
	
## Checks for specific patterns

# See if one value appears twice
func _IsTwoOfAKind():
	for dieFace in valueStorage:
		if valueStorage[dieFace] == 2:
			return true;
	return false;
	
# See if one value appears three times
func _IsThreeOfAKind():
	for dieFace in valueStorage:
		if valueStorage[dieFace] == 3:
			return true;
	return false;

# See if one value appears four times
func _IsFourOfAKind():
	for dieFace in valueStorage:
		if valueStorage[dieFace] == 4:
			return true;
	return false;

# See if one value is matching the total number of dice
func _IsGodotzy():
	# Loop over, if any of them are not a 0 or 5, it's not a Godotzy
	for dieFace in valueStorage:
		var faceValue = valueStorage[dieFace];
		if faceValue > 0 and faceValue < 5:
			return false;
	return true;

# See if we have a pair and triple
func _IsFullHouse():
	var foundPair = false;
	var foundTrip = false;
	for dieFace in valueStorage:
		var faceValue = valueStorage[dieFace];
		if faceValue == 2:
			foundPair = true;
		elif faceValue == 3:
			foundPair = true;
			
	return foundPair && foundTrip;

# See if all small numbers have one
func _IsSmallStraight():
	return (
		   valueStorage[1] == 1
		&& valueStorage[2] == 1
		&& valueStorage[3] == 1
		&& valueStorage[4] == 1
		&& valueStorage[5] == 1
	);

# See if all large numbers have one
func _IsLargeStraight():
	return (
		   valueStorage[2] == 1
		&& valueStorage[3] == 1
		&& valueStorage[4] == 1
		&& valueStorage[5] == 1
		&& valueStorage[6] == 1
	);
