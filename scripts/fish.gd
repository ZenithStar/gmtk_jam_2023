extends RigidBody2D


var facing_left = false
func _process(_delta):
	if Input.is_action_pressed("right"):
		$Sprite2D.flip_h = false
	elif Input.is_action_pressed("left"):
		$Sprite2D.flip_h = true


var GRAVITY = ProjectSettings.get_setting("physics/2d/default_gravity") * ProjectSettings.get_setting("physics/2d/default_gravity_vector")
var MAX_THRUST = 300


func _integrate_forces(state):
	var buoyancy = Vector2.ZERO
	#var water = get_parent().get_node('ParallaxForeground/ParallaxLayer2/Water')
	#if water.overlaps_body(self):
	if position.y > -490:
		buoyancy = -1.001 * GRAVITY * mass

	var thrust_x = 0
	if Input.is_action_pressed("right"):
		thrust_x = 1
	elif Input.is_action_pressed("left"):
		thrust_x = -1
	var thrust = Vector2(1, 0) * thrust_x * MAX_THRUST
	
	if Input.is_action_pressed("up"):
		thrust = thrust.rotated(-sign(thrust_x) * PI/4)
	elif Input.is_action_pressed("down"):
		thrust = thrust.rotated(sign(thrust_x) * PI/4)

	state.apply_force(thrust + buoyancy)
