extends RigidBody2D


@onready var water = get_parent().get_node('Foreground/Water')


var GRAVITY = ProjectSettings.get_setting("physics/2d/default_gravity") * ProjectSettings.get_setting("physics/2d/default_gravity_vector")
@export var MAX_THRUST = 5000
@export var MAX_VELOCITY = 1000

var first_call = true

func _integrate_forces(state):
	if first_call:
		# for some reason the water.overlaps_body(self) is wrong the first time 
		# this function is called
		first_call = false
		return

	var is_in_water = water.overlaps_body(self)

	var buoyancy = -1.01 * GRAVITY * mass if is_in_water else Vector2.ZERO

	var thrust = Vector2.ZERO
	if Input.is_action_pressed("right"):
		thrust.x = 1
	elif Input.is_action_pressed("left"):
		thrust.x = -1
	if Input.is_action_pressed("down"):
		thrust.y = .4
	elif Input.is_action_pressed("up"):
		thrust.y = -.4
	thrust = thrust.normalized() * MAX_THRUST * mass
	if !is_in_water:
		# can't move as fast out of water, and remove vertical thrust
		thrust *= Vector2(.1, 0)

	var dampening_factor = 0
	if !is_in_water:
		# don't dampen speed while in air
		dampening_factor = 0
	elif thrust.length() == 0:
		# slow down quickly when not actively controlling
		dampening_factor = 1 * mass
	else:
		# set dampening based on desired terminal velocity
		dampening_factor = MAX_THRUST * mass / MAX_VELOCITY
	var dampening = -state.linear_velocity * dampening_factor

	if thrust.length() != 0 or !is_in_water:
		if state.linear_velocity.x < 0:
			$Sprite2D.flip_h = true
		elif state.linear_velocity.x > 0:
			$Sprite2D.flip_h = false
		$Sprite2D.rotation = state.linear_velocity.angle() + (PI if $Sprite2D.flip_h else 0)

	state.apply_force(dampening + thrust + buoyancy)
