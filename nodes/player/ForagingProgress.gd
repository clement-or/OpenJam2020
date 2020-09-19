extends ProgressBar

func _ready():
	max_value = $"../ForagingTimer".wait_time

func _process(delta):
	value = $"../ForagingTimer".time_left
