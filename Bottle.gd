extends Node2D;


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var animatedSprite = get_node("AnimatedSprite");
	var bottleNames  = animatedSprite.frames.get_animation_names();
	var val = randi();
	animatedSprite.play(bottleNames[ val % bottleNames.size() ]);


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	var animatedSprite = get_node("AnimatedSprite");
#	var bottleNames  = animatedSprite.frames.get_animation_names();
#	var val = randi();
#	animatedSprite.play(bottleNames[ val % bottleNames.size() ]);
#	pass
