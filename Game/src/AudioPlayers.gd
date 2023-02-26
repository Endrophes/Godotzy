extends Node
class_name MainAudio

var effectPlayer;

# Called when the node enters the scene tree for the first time.
func _ready():
	effectPlayer = get_node("Effect");


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _stopMusic():
	pass

func _PlayEffect():
	# Godotzy for now
	effectPlayer.play();
