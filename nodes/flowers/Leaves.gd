extends Node

var visible_leaves = []

#LEAVES ARE GIVEN UP UPPON, SET IT BACK TO VISIBLE IF WORK INTENDED

func setup():
	var id = 0
	for a_leaf in get_children():
		randomize()
		var i = rand_range(0,4)
		if(i <= 1):
			visible_leaves.push_back(id)
			a_leaf.visible = true
			i = (i+0.5)
			if(i>1):i=1
			if(a_leaf.scale.x < 0):
				a_leaf.set_scale(Vector2(-i,i))
			else:
				a_leaf.set_scale(Vector2(i,i))
		else:
			a_leaf.visible = false
		id+=1