extends RigidBody2D


var facing_left = false
func _process(_delta):
	if Input.is_action_pressed("right"):
		$Sprite2D.flip_h = false
	elif Input.is_action_pressed("left"):
		$Sprite2D.flip_h = true


var MAX_THRUST = 5000
var thrust_x = 0
func _integrate_forces(state):
	if Input.is_action_pressed("right"):
		thrust_x += 0.1
	if Input.is_action_pressed("left"):
		thrust_x -= 0.1
	thrust_x = clamp(thrust_x, -1, 1)
	var thrust = Vector2(1, 0) * thrust_x * MAX_THRUST
	
	if Input.is_action_pressed("up"):
		thrust = thrust.rotated(-sign(thrust_x) * PI/4)
	elif Input.is_action_pressed("down"):
		thrust = thrust.rotated(sign(thrust_x) * PI/4)

	state.apply_force(thrust)
