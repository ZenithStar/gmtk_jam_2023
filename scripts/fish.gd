extends RigidBody2D
class_name Fish

@onready var water = get_parent().get_node('Foreground/Water')

var GRAVITY = ProjectSettings.get_setting("physics/2d/default_gravity") * ProjectSettings.get_setting("physics/2d/default_gravity_vector")
@export var MAX_THRUST = 5000
@export var THRUST_COMMAND: Vector2 = Vector2(1,.4)
@export var MAX_VELOCITY = 1000
@export var grab_stiffness_override = 30

var grabbers: Array = []
var GRABBER_CLASS_LEFT : PackedScene = preload("res://nodes/grab_joint_left.tscn")
var GRABBER_CLASS_RIGHT : PackedScene = preload("res://nodes/grab_joint_right.tscn")
func _process(delta):
	if Input.is_action_just_pressed("interact"):
		var area = $InteractAreaLeft if $Sprite2D.flip_h else $InteractAreaRight
		var origin = $GrabOriginLeft if $Sprite2D.flip_h else $GrabOriginRight
		var grabber_class = GRABBER_CLASS_LEFT if $Sprite2D.flip_h else GRABBER_CLASS_RIGHT
		for body in area.get_overlapping_bodies():
			if  not (body is Fish) and (body is PhysicsBody2D):
				var grabber = grabber_class.instantiate()
				origin.add_child(grabber)
				grabber.stiffness = grab_stiffness_override * body.mass
				grabber.node_a = get_path()
				grabber.node_b = body.get_path()
				grabbers.append(grabber)
				print( "grabbing ", body)
				break
	elif Input.is_action_just_released("interact"):
		for grabber in grabbers:
			grabber.queue_free()
		grabbers = []
		
func maybe_play_swim_sounds(is_in_water):
	var swimSounds = false
	var someSound = 0;
	
	if Input.is_action_just_pressed("right"):
		if is_in_water:
			swimSounds = true
			
	if Input.is_action_just_pressed("left"):
		if is_in_water:
			swimSounds = true
		
	if Input.is_action_just_pressed("down"):
		if is_in_water:
			swimSounds = true

	if Input.is_action_just_pressed("up"):
		if is_in_water:
			swimSounds = true

	if swimSounds:
		someSound = (randi() % 5)
		if someSound == 0:
			$move1.play()
			return
		elif someSound == 1:
			$move2.play()
			return
		elif someSound == 2:
			$move3.play()
			return
		else:
			return
	# no sound 40% of the time

var first_splash = true

func splashes():
	if first_splash:
		first_splash = false
	else:
		$splash.play()

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
