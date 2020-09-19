extends ProgressBar

export(NodePath) var player_path
var player

func _ready():
	if player_path:
		player = get_node(player_path)

func _process(delta):
	if player:
		value = player.cur_flight

