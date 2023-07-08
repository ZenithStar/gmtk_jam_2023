extends RigidBody2D
class_name Buoyant

@export var buoyant_factor : float = 1.0
var submerged = false
@onready var gravity_vector : Vector2 = ProjectSettings.get_setting("physics/2d/default_gravity_vector")
@onready var gravity_magnitude : int = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var buoyant_force = - buoyant_factor * gravity_vector * gravity_magnitude * mass

func set_submerged(val:bool):
	submerged = val
	if submerged:
		add_constant_central_force(buoyant_force)
		print(name," buoyant_force added ", buoyant_force)
	else:
		constant_force = Vector2(0, 0)
	
