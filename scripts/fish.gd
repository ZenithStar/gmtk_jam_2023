extends RigidBody2D


var facing_left = false
func _process(_delta):
	if Input.is_action_pressed("right"):
		$Sprite2D.flip_h = false
	elif Input.is_action_pressed("left"):
		$Sprite2D.flip_h = true


var GRAVITY = ProjectSettings.get_setting("physics/2d/default_gravity") * ProjectSettings.get_setting("physics/2d/default_gravity_vector")
@export var MAX_THRUST = 5000
@export var MAX_VELOCITY = 1000

func _integrate_forces(state):
	var buoyancy = Vector2.ZERO
	var thrust = Vector2.ZERO

	#var water = get_parent().get_node('ParallaxForeground/ParallaxLayer2/Water')
	#if water.overlaps_body(self):
	var is_in_water = position.y > -450
	if is_in_water:
		buoyancy = -1.01 * GRAVITY * mass

		if Input.is_action_pressed("right"):
			thrust.x = 1
		elif Input.is_action_pressed("left"):
			thrust.x = -1
		if Input.is_action_pressed("down"):
			thrust.y = .4
		elif Input.is_action_pressed("up"):
			thrust.y = -.4
		thrust = thrust.normalized() * MAX_THRUST
	
	var dampening = Vector2.ZERO
	if thrust.length() == 0:
		dampening = -2 * state.linear_velocity
	else:
		# calculate dampening for desired terminal velocity
		dampening = -MAX_THRUST / (mass * MAX_VELOCITY) * state.linear_velocity

	state.apply_force(dampening + thrust + buoyancy)
