extends Node2D
class_name Dice

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
	print(alphaLevel)
	
func _roll():
	print("Random BS GO!!!")
