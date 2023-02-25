extends Node2D
class_name Dice

# Preload Dice faces
var dieFaces = {
	1 : preload("res://assets/Images/dieWhite1.png"),
	2 : preload("res://assets/Images/dieWhite2.png"),
	3 : preload("res://assets/Images/dieWhite3.png"),
	4 : preload("res://assets/Images/dieWhite4.png"),
	5 : preload("res://assets/Images/dieWhite5.png"),
	6 : preload("res://assets/Images/dieWhite6.png")
};


# Declare member variables here. Examples:
var value = 1;
var isLocked = false;

# Sub-Nodes
var selectedImage;
var dieSprite;
var lockButton;

# Called when the node enters the scene tree for the first time.
func _ready():
	lockButton    = get_node("Button");
	selectedImage = get_node("Selected");
	dieSprite     = get_node("Die");
	
	lockButton.connect("pressed", self, "_button_pressed");

func _button_pressed():
	isLocked = !isLocked;
		
	# this is a Ternary... It works... but I hate it.
	# Normal:   [Expression] [true] [false]
	# GDScript: [true] [Expression] [false] :P
	selectedImage.modulate.a = (1 if isLocked else 0);
	# print(alphaLevel)

# Change the value of the die
func _roll():
	# Don't roll if locked
	if !isLocked:
		value = 0;
		# Keep rolling till we get a value that's not zero
		while value == 0:
			value = randi() % 7; #Note: Its Exclusive
#		print("New Value:", value);
		dieSprite.set_texture(dieFaces[value]);
	
	return value;

func _getValue():
	return value;
