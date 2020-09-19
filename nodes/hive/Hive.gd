extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var stock = 0;
var lvl = 1;
var limit_before_update = 10;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func get_nectar(nectar: int):
	if(lvl < 3):
		stock = stock + nectar;
		if(stock > limit_before_update):
			upgrade();
			stock = stock - limit_before_update;

func upgrade():
	lvl = lvl + 1;
	$grow.play();
