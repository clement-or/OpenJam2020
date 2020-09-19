extends KinematicBody2D

export var gravity = 10

export var v_acceleration = 150
export var v_max_speed = 100

export var h_acceleration = 10
export var h_max_speed = 150

# The velocity of the bee
var velocity = Vector2.ZERO


func _ready():
	pass

func _process(delta):
	_movement()
	_animation()


func _movement():
	# Récupérer l'input du joueur
	var x_vel = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	var y_vel = int(Input.is_action_pressed("ui_up"))
	
	# Mouvement vertical
	velocity.y -= y_vel * v_acceleration
	velocity.y = clamp(velocity.y, -v_max_speed, 1000)
	
	# Mouvement horizontal
	velocity.x += x_vel * v_acceleration
	if !x_vel:
		velocity.x = lerp(velocity.x, 0, .8)
	velocity.x = clamp(velocity.x, -h_max_speed, h_max_speed)
	
	# Gravité
	if (!is_on_floor()):
		velocity.y += gravity
	
	# Appliquer le mouvement
	velocity = move_and_slide(velocity)


func _animation():
	$Sprite.flip_h = velocity.x < 0
