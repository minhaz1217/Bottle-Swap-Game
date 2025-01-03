extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
#	Debug.print("HI");
	print_debug("DEBUG")
	print("Button Pressed")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print("HI")
#	pass

func buttonPressed(index):
	print("Button Pressed")
