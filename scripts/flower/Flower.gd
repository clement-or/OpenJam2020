extends Node2D

var id = "flower01"
var flower_name = "" #would be equal something in data ling by ID
var flower_nectar
var stem_height = 800 #would be equal something in data ling by ID
var is_polinised = true
var is_gleaned = false

func _process(delta):
	if(is_polinised && is_gleaned):
		$RenewNectarTimer.start()

func _on_RenewNectarTimer_timeout():
	is_gleaned = false

func get_gleaned():
	is_gleaned = true
	$Head.modulate = Color(1,1,1,0.5)