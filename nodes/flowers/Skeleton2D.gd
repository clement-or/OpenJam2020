extends Skeleton2D

func _on_Leaves_create_leaf(leaf, bone_position):
	print(leaf.name + " recieved, setting it in bone " + String(bone_position))
	match(int(bone_position)):
		0:$Bone1.add_child(leaf)
		1:$Bone1/Bone2.add_child(leaf)
		2:$Bone1/Bone2/Bone3.add_child(leaf)
	leaf.set_position(Vector2(0,0))
	move_child(find_node("leaf"), 0)
