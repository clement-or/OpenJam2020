extends KinematicBody2D

const START_FOLLOWING_DIST = 2000 # pixel
const FOLLOWING_TIME = 7 * 60 # number of frames
const STOP_FOLLOWING_FOR = 5 # duration in s
const FLIGHT_DAMAGES = 5

var bee # the Player node

var is_following_bee = false
var can_follow_bee = true
var is_up_to_bee
var is_left_to_bee

var dist_to_bee
var followed_for = 0

var velocity = Vector2(150, 100)


# Initialize the variables
func _ready():
	# Path to change when integrated in the game
	assert(get_node("/root/Node2D/CenteredCam/Player"))
	bee = get_node("/root/Node2D/CenteredCam/Player")


# Activates every frame
func _physics_process(delta):
	# If the hornet collide the bee, deals it flight damage and stop following it
	var collision_info = move_and_collide(velocity * delta)

	if collision_info != null and collision_info.get_collider() == bee: # and bee != is_immune
		bee.cur_flight -= FLIGHT_DAMAGES
		_stop_following()
	
	else:
		# Set the variables used to know where is the bee
		var v_dif = bee.position.y - self.position.y
		var h_dif = bee.position.x - self.position.x
		
		is_up_to_bee = v_dif > 0
		is_left_to_bee = h_dif > 0
	
		dist_to_bee = sqrt(v_dif * v_dif + h_dif * h_dif)
		
		# Follow the bee
		if can_follow_bee and dist_to_bee < START_FOLLOWING_DIST:
			is_following_bee = true
			_movement(abs(h_dif), abs(v_dif))
			followed_for += 1
			if followed_for >= FOLLOWING_TIME:
				_stop_following()


# The hornet stops to follow the bee for the amount of time in STOP_FOLLOWING_FOR
func _stop_following():
	# Stop following the bee and can't follow it anymore
	is_following_bee = false
	can_follow_bee = false
	
	# Wait before being able to follow the bee again
	var timer = Timer.new()
	timer.set_wait_time(STOP_FOLLOWING_FOR)
	timer.set_one_shot(true)
	self.add_child(timer)
	timer.start()
	yield(timer, "timeout")
	
	# Can follow anew
	can_follow_bee = true


# Move the hornet
# h_length: The horizontal length between the hornet and the bee
# v_length: The vertical length between the hornet and the bee
func _movement(h_length, v_length):
	# Calcul the angle of the right-rectangle that links the hornet and the bee
	var tangente = 0
	if v_length > h_length:
		tangente = v_length / h_length
	else:
		tangente = h_length / v_length
	
	var right_triangle_angle = atan(tangente)
	
	# Calcul the angle in radiant in which the hornet must move
	var angle
	if(is_up_to_bee):
		if(is_left_to_bee):
			angle = PI - right_triangle_angle
		else:
			angle = PI * 1.5 - right_triangle_angle
	else:
		if(is_left_to_bee):
			angle = PI * 0.5 - right_triangle_angle
		else:
			angle = PI * 2 - right_triangle_angle

	# Move
	move_and_slide(velocity, Vector2(0, 1).rotated(angle))
