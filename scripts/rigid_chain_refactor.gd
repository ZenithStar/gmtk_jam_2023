extends Joint2D
class_name RigidChainLineOmega

@export var num_chain_segments: int = 50
@export var segment_length: int = 10
@export var width: int = 1

var packed : PackedScene

func _ready():
	var segment_offset = Vector2(-segment_length,0)
	var half_segment = segment_offset/2
	var segment = SegmentShape2D.new()
	segment.a = -half_segment
	segment.b = half_segment
	var packed_vec = PackedVector2Array([-half_segment, half_segment])
	var body_base = RigidBody2D.new()
	body_base.transform.origin = half_segment
	var collision = CollisionShape2D.new()
	collision.shape = segment
	body_base.add_child(collision)
	var line = Line2D.new()
	line.points = packed_vec
	line.width = width
	body_base.add_child(line)
	var pin = PinJoint2D.new()
	pin.name = "PinJoint2D"
	body_base.add_child(pin)
	
	packed = PackedScene.new()
	packed.pack(body_base)
	
	var parent = get_node(node_a)
	for i in range(num_chain_segments):
		parent = add_piece(parent)
	var last_joint = parent.get_node("PinJoint2D")
	last_joint.node_a = parent.get_path()
	last_joint.node_b = node_b
	
func add_piece(parent):
	var joint = parent.get_node("PinJoint2D")
	var piece = packed.instantiate()
	joint.add_child(piece)
	joint.node_a = parent.get_path()
	joint.node_b = piece.get_path()
	
	return piece
	
