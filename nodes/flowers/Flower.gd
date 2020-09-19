extends Node2D
signal has_been_entered(flower_encountered)

var id = "flower01"
var flower_name = "" #Valeur ajoutée à l'avenir avec un tableau de valeur
var nectar = { #Les valeurs du nectar seront récupérées en fonction de l'ID de la fleur dans un tableau de valeur
	"name": "base_nectar",
	"value": 1,
	"color": Color("#a5da00")
	}
#var stem_height = 400 #Pas sûr de l'utilité, garder ça dans le coin de la tête
var is_polinised = true
var is_gleaned = false
var visible_leaves = []


func _ready():
	$Leaves.setup()
	var a_leaf_id = 0
	for a_leaf in $Leaves.get_children() :
		match(a_leaf_id): #BROKEN
			0: $Skeleton2D/Bone1.add_child($Leaves.get_child(a_leaf_id))
			1: $Skeleton2D/Bone1/Bone2.add_child($Leaves.get_child(a_leaf_id))
			2: $Skeleton2D/Bone1/Bone2/Bone3.add_child($Leaves.get_child(a_leaf_id))
			3: $Skeleton2D/Bone1.add_child($Leaves.get_child(a_leaf_id))
			4: $Skeleton2D/Bone1/Bone2.add_child($Leaves.get_child(a_leaf_id))
			5: $Skeleton2D/Bone1/Bone2/Bone3.add_child($Leaves.get_child(a_leaf_id))
		

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
