extends Node2D

# Nodes componets
var rollButton;
var scoreDisplay;
var patternDisplay;

# Holds the dice nodes
var diceStorage = [];

# Holds the count for all face values
var valueStorage = {
	1 : 0,
	2 : 0,
	3 : 0,
	4 : 0,
	5 : 0,
	6 : 0
};

# Holds all the string values for the pattern names
const patternNames = {
	0 : "None",
	1 : "Large Straight",
	2 : "Small Straight",
	3 : "Full House",
	4 : "GODOTZY!",
	5 : "4 of a kind",
	6 : "3 of a kind",
	7 : "2 of a kind"
};

# Called when the node enters the scene tree for the first time.
func _ready():
	# Get all components
	#TODO:
	# I really should find another way to get the nodes
	# Change the name, break the code
	diceStorage    = get_node("DiceStorage").get_children();
	rollButton     = get_node("Roll");
	scoreDisplay   = get_node("ScoreDisplay");
	patternDisplay = get_node("PatternDisplay");
	
	rollButton.connect("pressed", self, "_Roll_The_Dice");
	
#	print(diceStorage);
#	print(rollButton);
	
	_reset();
	
# Sets everything back to start values
func _reset():
	scoreDisplay.text = str(0);
	for dieFace in valueStorage:
		valueStorage[dieFace] = 0;
	return;

# Rolls all the dice
func _Roll_The_Dice():
#	print("ROLLEN ROLLEN ROLLEN")
	_reset();

	var score = 0;
	for die in diceStorage:
		die._roll();
		score += die._getValue();
		valueStorage[die._getValue()] += 1;
	
#	print(valueStorage);
	
	scoreDisplay.text = str(score);
	
	# Order of the if checks covers other smaller patterns
	# EX:
	# * With a full house, you have 2 and 3 of a kind.
	# * A Large and Small Straight make the other patterns not possible
	
	# Determines the dice pattern based on the dice face
	
	if   _IsLargeStraight():
		patternDisplay.text = patternNames[1];
	elif _IsSmallStraight():
		patternDisplay.text = patternNames[2];
	elif _IsFullHouse():
		patternDisplay.text = patternNames[3];
	elif _IsGodotzy():
		patternDisplay.text = patternNames[4];
	elif _IsFourOfAKind():
		patternDisplay.text = patternNames[5];
	elif _IsThreeOfAKind():
		patternDisplay.text = patternNames[6];
	elif _IsTwoOfAKind():
		patternDisplay.text = patternNames[7];
	else:
		patternDisplay.text = patternNames[0];
	
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
			
	return (foundPair && foundTrip);

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
