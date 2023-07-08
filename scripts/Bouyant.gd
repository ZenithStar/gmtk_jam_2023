extends RigidBody2D
class_name Bouyant

@export var bouyancy_factor : float = 2.0
var submerged = false
var gravity_vector : Vector2 = ProjectSettings.get_setting("physics/2d/default_gravity_vector")
var gravity_magnitude : int = ProjectSettings.get_setting("physics/2d/default_gravity")
var bouyant_force = - bouyancy_factor * gravity_vector * gravity_magnitude * mass

func set_submerged(val:bool):
	submerged = val
	if submerged:
		add_constant_central_force(bouyant_force)
	else:
		constant_force = Vector2(0, 0)
	
