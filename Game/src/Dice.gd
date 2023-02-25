extends Node2D
class_name Dice

# Preload Dice faces
var die1 = preload("res://assets/Images/dieWhite1.png")
var die2 = preload("res://assets/Images/dieWhite2.png")
var die3 = preload("res://assets/Images/dieWhite3.png")
var die4 = preload("res://assets/Images/dieWhite4.png")
var die5 = preload("res://assets/Images/dieWhite5.png")
var die6 = preload("res://assets/Images/dieWhite6.png")

# Declare member variables here. Examples:
var value = 1;
var isLocked = false;
var selectedImage;

# Called when the node enters the scene tree for the first time.
func _ready():
	var button = get_node("Button")
	button.connect("pressed", self, "_button_pressed")
	selectedImage = get_node("Selected")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	if InputEventMouse:
#		print("HIT")

func _button_pressed():
	isLocked = !isLocked;
	var alphaLevel = 0;
	if isLocked:
		alphaLevel = 1;
		
	selectedImage.modulate.a = alphaLevel
	# print(alphaLevel)
	
func _roll():
	if !isLocked:
		value = 0;
		while value == 0:
			value = randi() % 7;
#		print("New Value:", value);
		_changeSprite();
	else:
#		print("Nope");
		return;

func _changeSprite():
	var newTexture = die1;
	
	match (value):
		1 :
			newTexture = die1;
		2 :
			newTexture = die2;
		3 :
			newTexture = die3;
		4 :
			newTexture = die4;
		5 :
			newTexture = die5;
		6:
			newTexture = die6;
	
	var dieSprite = get_node("Die");
	dieSprite.set_texture(newTexture);

func _getValue():
	return value;
