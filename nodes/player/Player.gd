extends KinematicBody2D

export var gravity = 10

export var v_acceleration = 150
export var v_max_speed = 100

export var h_acceleration = 10
export var h_max_speed = 150

# La valeur de vol 
export var max_flight = 100
export var refill_rate = 1
var cur_flight = 100

# La vélocité de l'abeille
var velocity = Vector2.ZERO
var acceleration = Vector2.ZERO

var cur_pollen = {"name": "", "value": 0, "color": null} setget set_cur_pollen


func _ready():
	pass

func _process(delta):
	_movement()
	_animation()
	if is_on_floor():
		cur_flight += refill_rate
		cur_flight = clamp(cur_flight, 0, max_flight)
	print(is_on_floor())



func _movement():
	# Récupérer l'input du joueur
	var x_vel = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	var y_vel = int(Input.is_action_pressed("ui_up"))
	
	# Soustraire la valeur de vol
	if Input.is_action_pressed("ui_up"):
		cur_flight -= .1
	
	# Empêcher le joueur de voler si il n'a plus de vol disponible
	if cur_flight <= 0:
		y_vel = 0
	
	# Mouvement vertical
	acceleration.y = - y_vel * v_acceleration
	velocity.y += acceleration.y
	velocity.y = clamp(velocity.y, -v_max_speed, 1000)
	
	# Mouvement horizontal
	acceleration.x = x_vel * h_acceleration
	velocity.x += acceleration.x
	if !x_vel:
		velocity.x = lerp(velocity.x, 0, .8)
	velocity.x = clamp(velocity.x, -h_max_speed, h_max_speed)
	
	# Gravité
	#if (!is_on_floor()):
	velocity.y += gravity
	
	# Appliquer le mouvement
	velocity = move_and_slide(velocity, Vector2.UP)
	
	# Dessiner les choses définies dans la fonction _draw()
	update()

func _animation():
	$Sprite.flip_h = velocity.x < 0


# Donner/retirer un pollen à l'abeille. Start les particules et joue un petit "burst"
func set_cur_pollen(var pollen : Dictionary):
	$PollenFall.emitting = pollen.name
	
	# Si on ajoute un pollen à l'abeille
	if pollen.get("name"):
		
		$PollenBurst.self_modulate = pollen.color
		$PollenFall.self_modulate = pollen.color
		$PollenBurst.emitting = true
	# Sinon, faire en sorte qu'on enlève le pollen à l'abeille
	# Si un pollen n'a pas de nom, on considère que l'abeille n'a pas de pollen
	else:
		cur_pollen = {"name": "", "value": 0, "color": null}



func _draw():
	return
	draw_line(position, position+acceleration, Color.red)
	draw_circle(position+acceleration, 2, Color.red)
