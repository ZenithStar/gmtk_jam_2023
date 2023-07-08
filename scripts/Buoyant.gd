extends RigidBody2D
class_name Buoyant

@export var buoyant_factor : float = 2.0
@export var water_drag := 0.05
@export var water_angular_drag := 0.05

@onready var gravity_vector : Vector2 = ProjectSettings.get_setting("physics/2d/default_gravity_vector")
@onready var gravity_magnitude : float = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var buoyant_force = - buoyant_factor * gravity_vector * gravity_magnitude * mass

var submerged = false
const water_height := -520

func set_submerged(val:bool):
	submerged = val
	if submerged:
		add_constant_central_force(buoyant_force)
	else:
		constant_force = Vector2(0, 0)
	
func _physics_process(delta):
	var depth = -1 * (water_height - global_position.y)
	if depth > 0:
		submerged = true
		apply_central_force(Vector2.UP * buoyant_factor * gravity_magnitude * depth)
	else:
		submerged = false
		
func _integrate_forces(state):
	if submerged:
		state.linear_velocity *= 1 - water_drag
		state.angular_velocity *= 1 - water_angular_drag
