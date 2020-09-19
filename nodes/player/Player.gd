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

var cur_nectar = {"name": "", "value": 0, "color": null} setget set_cur_nectar

var near_flower
var is_foraging = false


""" Main methods"""


func _ready():
	pass

func _physics_process(delta):
	_movement()
	_animation()
	if is_on_floor():
		cur_flight += refill_rate
		cur_flight = clamp(cur_flight, 0, max_flight)

func _input(event):
	# Si le joueur est proche d'une fleur et au sol alors il peut butiner
	if Input.is_action_just_pressed("ui_down"):
		if near_flower && is_on_floor():
			if near_flower.nectar != cur_nectar && $ForagingTimer.is_stopped():
				_start_foraging()
	
	# Si le joueur relâche la touche alors qu'il butine, stopper
	if Input.is_action_just_released("ui_down") || Input.is_action_pressed("ui_up") || Input.is_action_pressed("ui_left") || Input.is_action_pressed("ui_right"):
		if !$ForagingTimer.is_stopped():
			_stop_foraging()
	

""" Helpers """


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
	velocity.y += gravity
	
	# Coller aux plateformes mouvantes
	#look_at(get_floor_normal())
	
	# Appliquer le mouvement
	velocity = move_and_slide(velocity, Vector2.UP)
	
	# Dessiner les choses définies dans la fonction _draw()
	update()


func _animation():
	$Sprite.flip_h = velocity.x < 0
	
	if is_foraging:
		$Anim.play("foraging")
	else:
		$Anim.stop()


func _start_foraging():
	$ForagingTimer.start()
	is_foraging = true
	$ForagingProgress.visible = true

func _stop_foraging():
	$ForagingTimer.stop()
	is_foraging = false
	$ForagingProgress.visible = false


""" Setters/getters """


# Donner/retirer un nectar à l'abeille. Start les particules et joue un petit "burst"
func set_cur_nectar(var nectar : Dictionary):
	$PollenFall.emitting = nectar.name != ""
	
	# Si on ajoute un nectar à l'abeille
	if nectar.get("name"):
		
		$PollenBurst.self_modulate = nectar.color
		$PollenFall.self_modulate = nectar.color
		$PollenBurst.emitting = true
		cur_nectar = nectar
	# Sinon, faire en sorte qu'on enlève le nectar à l'abeille
	# Si un nectar n'a pas de nom, on considère que l'abeille n'a pas de nectar
	else:
		cur_nectar = {"name": "", "value": 0, "color": null}


""" Signals methods """


func _on_Flower_entered(flower_encountered):
	near_flower = flower_encountered

func _on_foraging_finished():
	set_cur_nectar(near_flower.nectar)
	is_foraging = false
	$ForagingProgress.visible = false


""" Debug """


func _draw():
	return
	draw_line(position, position+acceleration, Color.red)
	draw_circle(position+acceleration, 2, Color.red)


""" Others """


func get_class(): return "Player"
