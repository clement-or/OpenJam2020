extends StaticBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().get_root().connect("size_changed", self, "_change_floor_pos")
	_change_floor_pos()

func _change_floor_pos():
	var y_translate = $"../Parallax/ForegroundPannel".get_motion_scale().y
	var foreground = $"../Parallax/ForegroundPannel/Foreground"
	var pos = $"../Parallax/ForegroundPannel".position.y + foreground.position.y
	var screen_height = get_viewport_rect().size.y
	var foreground_height = foreground.texture.get_size().y
	
	print(y_translate)
	print(screen_height)
	
	var new_pos = (pos / 1920) * (y_translate) + 1920 + 469
	print(new_pos)
	
	self.position.y = new_pos #+ ((foreground_height * (2 - y_translate) + foreground.position.y) * (1 + y_translate)) + 1
	#get_viewport_rect().size.y

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var y_translate = $"../Parallax/ForegroundPannel".get_motion_scale().y
	var foreground = $"../Parallax/ForegroundPannel/Foreground"
	var pos = $"../Parallax/ForegroundPannel".position.y + foreground.position.y
	var screen_height = get_viewport_rect().size.y
	var foreground_height = foreground.texture.get_size().y
	
	#print(foreground.position.y)
	#print(foreground_height)
	#var new_pos = (pos / 1920) * (y_translate) + 1920 + 469
	var new_pos = self.position.y * y_translate + foreground_height / 2 * y_translate + 1 + 1980 + 100000
	#print(new_pos)
	#obj.position.y = obj.position.y * px_scale.y #- get_viewport().size.y/2
	
	self.position.y = new_pos
#	pass
#limit = 2300
