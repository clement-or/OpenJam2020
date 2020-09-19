extends Node2D
signal has_been_entered(flower_encountered)

var id = "BASE"
var flower_name = "BASE"
var flower_visual_path = "res://resources/sprites/placeholders/flowerHead.png"
var nectar = {
	"name": "BASE",
	"value": 0,
	"color": Color(255,255,255)
	}
var stem_height = 900
var is_polinised = true
var is_gleaned = false
var can_have_leaves = true


func set_variables(var i, var f_n, var nctr, var st_hgt, var c_h_l):
	id = i
	flower_name = f_n
	nectar = nctr
	stem_height = st_hgt
	can_have_leaves = c_h_l
	$Leaves.setup(can_have_leaves, id)
	randomize()
	var rand = rand_range(0.8,1.4)
	$Anim.set_speed_scale(rand)
	set_height()

func set_height():
	randomize()
	var new_scale = 1.0/(900.0/stem_height) + rand_range(-0.1,0.1)
	self.set_scale(Vector2(new_scale, new_scale))

func _on_RenewNectarTimer_timeout():
	is_gleaned = false
	$Head.modulate = Color(1,1,1,1)

func has_been_gleaned():
	is_gleaned = true
	$Head.modulate = Color(1,1,1,0.5)
	if(is_polinised):
		$RenewNectarTimer.start()

func has_been_polinised():
	is_polinised = true
	if(is_gleaned):
		$RenewNectarTimer.start()

func get_nectar():
	return nectar

func _on_Area_body_entered(body):
	if(body.get_class() == "Player"):
		emit_signal("has_been_entered", self)
