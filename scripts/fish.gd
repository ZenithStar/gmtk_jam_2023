extends RigidBody2D


@onready var water = get_parent().get_node('Foreground/Water')


var GRAVITY = ProjectSettings.get_setting("physics/2d/default_gravity") * ProjectSettings.get_setting("physics/2d/default_gravity_vector")
@export var MAX_THRUST = 5000
@export var THRUST_COMMAND: Vector2 = Vector2(1,.4)
@export var MAX_VELOCITY = 1000


func maybe_play_swim_sounds(is_in_water):
	var swimSounds = false
	var someSound = 0;
	
	if Input.is_action_pressed("right"):
		if is_in_water:
			if Input.is_action_just_pressed("right"):
				swimSounds = true
				
	elif Input.is_action_pressed("left"):
		if is_in_water:
			if Input.is_action_just_pressed("left"):
				swimSounds = true
				
	if Input.is_action_pressed("down"):
		if is_in_water:
			if Input.is_action_just_pressed("down"):
				swimSounds = true
				
	elif Input.is_action_pressed("up"):
		if is_in_water:
			if Input.is_action_just_pressed("up"):
				swimSounds = true

	if swimSounds:
		someSound = (randi() % 5)
		if someSound == 1:
			$move1.play()
			swimSounds = false
		elif someSound == 2:
			$move2.play()
			swimSounds = false
		elif someSound == 3:
			$move3.play()
			swimSounds = false
		elif someSound == 4:
			swimSounds = false
		else:
			swimSounds = false


var first_call = true
func _integrate_forces(state):
	if first_call:
		# for some reason the water.overlaps_body(self) is wrong the first time 
		# this function is called
		first_call = false
		return

	var is_in_water = water.overlaps_body(self)
	maybe_play_swim_sounds(is_in_water)

	var buoyancy = -1.01 * GRAVITY * mass if is_in_water else Vector2.ZERO

	var thrust = Vector2(Input.get_axis("left", "right"), Input.get_axis("up", "down"))
	thrust *= THRUST_COMMAND
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
