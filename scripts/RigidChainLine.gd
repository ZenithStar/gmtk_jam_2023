extends PinJoint2D
class_name RigidChainLine

@export var num_chain_segments: int = 50
@export var segment_length: int = 10
@export var width: int = 1

var bodies: Array
var pins: Array
var last_body: NodePath

func _ready():
	pins.append(self)
	var segment_offset = Vector2(-segment_length,0)
	var half_segment = segment_offset/2
	var segment = SegmentShape2D.new()
	segment.a = -half_segment
	segment.b = half_segment
	var packed_vec = PackedVector2Array([-half_segment, half_segment])
	var total_offset = Vector2.ZERO
	for i in range(num_chain_segments):
		var body = RigidBody2D.new()
		body.name = "RigidChainBody"+str(i)
		body.transform.origin = total_offset + half_segment
		bodies.append(body)
		add_child.call_deferred(body)
		var collision = CollisionShape2D.new()
		collision.shape = segment
		body.add_child(collision)
		var line = Line2D.new()
		line.points = packed_vec
		line.width = width
		body.add_child(line)
		var pin = PinJoint2D.new()
		pin.name = "RigidChainPin"+str(i)
		pin.transform.origin = total_offset
		pins.append(pin)
		add_child.call_deferred(pin)
		total_offset += segment_offset
	get_tree().create_timer(0.01).timeout.connect(set_pin_joints)

func set_pin_joints():
	last_body = node_b
	for i in range(num_chain_segments):
		var body_path = get_path_to(bodies[i])
		pins[i].set_node_b(body_path)
		pins[i+1].set_node_a(body_path)
	pins[-1].set_node_b(last_body)
	
