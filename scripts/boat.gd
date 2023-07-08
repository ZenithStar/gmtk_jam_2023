extends RigidBody2D
class_name Boat

@export var buoyant_factor : float = 2.0
@export var object_height = 100.0
@export var base_mass = 100.0
@onready var gravity_vector : Vector2 = ProjectSettings.get_setting("physics/2d/default_gravity_vector")
@onready var gravity_magnitude : float = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var buoyant_force = - buoyant_factor * gravity_vector * gravity_magnitude * mass / 2.0

var submerged = false
var water_height = -520
func _ready():
	mass = base_mass
	
func set_submerged(val:bool, height:float = 0):
	submerged = val
	water_height = height
	
func _physics_process(delta):
	if submerged :
		var left_depth = -1 * (water_height - $LeftForce.global_position.y)
		var right_depth = -1 * (water_height - $RightForce.global_position.y)
		apply_force(buoyant_force * left_depth * delta, $LeftForce.transform.origin)
		apply_force(buoyant_force * right_depth * delta, $RightForce.transform.origin)
		
