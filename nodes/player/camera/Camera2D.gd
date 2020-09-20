extends Camera2D

var smoothing = 1.0
var last_camera_pos	
var y_translate

# Called when the node enters the scene tree for the first time.
func _ready():
	last_camera_pos = self.position.y
	y_translate = get_tree().get_root().get_node("Main/Foreground/Parallax/ForegroundPannel").get_motion_scale().y
	#get_tree().get_root().connect("size_changed", self, "_change_limit")
	#_change_limit()

func _change_limit():
	assert(get_tree().get_root().get_node("Main/Foreground/Floor"))
	var floor_var = get_tree().get_root().get_node("Main/Foreground/Floor")
	self.limit_bottom = floor_var.get_position().y


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print(last_camera_pos)
	var parallax =  (last_camera_pos - self.position.y) * y_translate
	print(y_translate)
	print(parallax)
	var limit = self.limit_bottom + parallax
	self.limit_bottom = limit #lerp(self.limit_bottom, limit, smoothing * delta)

	last_camera_pos = self.position.y
	print(self.limit_bottom)
#	pass
