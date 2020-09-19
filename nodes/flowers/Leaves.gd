extends Node

export(PackedScene) var leaf

signal create_leaf(leaf, bone_position)

var leaves_created = []

func setup(var c_h_l, var flower_id):
	leaves_created.clear()
	if(!c_h_l): return
	print("setting leaves!")
	for id_leaf_tested in range(6):
		randomize()
		var rand = randi() % 3
		if(rand == 0):
			create_a_leaf(flower_id)

func create_a_leaf(var id):
	var is_left
	var bone_position
	var leaf_scale
	var rand
	
	print("creating a leaf for flower "+id)
	randomize()
	rand = randi() % 2
	is_left = (rand == 1)
	print("is_left :" + String(is_left))
	randomize()
	bone_position = randi() % 3
	print("bone_pos : " + String(bone_position))
	
	var new_save = String(is_left)+String(bone_position)
	if(leaves_created.has(new_save)):
		print("retrying...")
		create_a_leaf(id)
		return
	leaves_created.push_front(new_save)
	
	randomize()
	leaf_scale = rand_range(0.8,1.0)
	print("leaf_scale : " + String(leaf_scale))
	var new_leaf = leaf.instance()
	
	if(is_left):
		new_leaf.set_scale(Vector2(-leaf_scale,leaf_scale))
	else:
		new_leaf.set_scale(Vector2(leaf_scale,leaf_scale))
	print(String(new_leaf.name))
	emit_signal("create_leaf", new_leaf, bone_position)