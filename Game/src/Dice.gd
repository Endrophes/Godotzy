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

var dieRolls = {
	0 : preload("res://assets/Sounds/dieThrow1.ogg"),
	1 : preload("res://assets/Sounds/dieThrow2.ogg"),
};

# Declare member variables here. Examples:
var value = 1;
var isLocked = false;
var playRollSound = false;
var RollSoundDelay = float(0.0);

# Sub-Nodes
var selectedImage;
var dieSprite;
var lockButton;
var speaker;

# Called when the node enters the scene tree for the first time.
func _ready():
	lockButton    = get_node("Button");
	selectedImage = get_node("Selected");
	dieSprite     = get_node("Die");
	speaker       = get_node("AudioPlayer");
	
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
		
		playRollSound = true;
		RollSoundDelay = (randi() % 2) - randf();
#		print("RollSoundDelay: ", RollSoundDelay)
	
	return value;

func _getValue():
	return value;

func _playRollSound():
	var rollSound = randi() % 2;
	speaker.set_stream(dieRolls[rollSound]);
	speaker.set_volume_db(randi() % 6);
	speaker.play();

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if playRollSound:
		RollSoundDelay -= delta;
		if RollSoundDelay <= 0:
			RollSoundDelay = 0;
			_playRollSound();
			playRollSound = false;
	
