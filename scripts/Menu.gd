extends Control

onready var particle_left = $ParticuleLeft
onready var particle_right = $ParticuleRight

func _on_Start_mouse_entered():
	particle_left.visible = true
	particle_right.visible = true
	particle_left.set_position($VBoxContainer/Start/Control.get_global_position())
	particle_right.set_position($VBoxContainer/Start/Control2.get_global_position())


func _on_HowToPlay_mouse_entered():
	particle_left.visible = true
	particle_right.visible = true
	particle_left.set_position($VBoxContainer/HowToPlay/Control.get_global_position())
	particle_right.set_position($VBoxContainer/HowToPlay/Control2.get_global_position())


func _on_Exit_mouse_entered():
	particle_left.visible = true
	particle_right.visible = true
	particle_left.set_position($VBoxContainer/Exit/Control.get_global_position())
	particle_right.set_position($VBoxContainer/Exit/Control2.get_global_position())

func _on_button_mouse_exit():
	particle_left.visible = false
	particle_right.visible = false
