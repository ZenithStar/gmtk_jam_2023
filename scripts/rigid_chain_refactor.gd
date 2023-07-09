extends Node2D
class_name RigidChainLineOmega

@export var num_chain_segments: int = 50
@export var segment_length: int = 10
@export var width: int = 1
@export var node_a: NodePath
@export var node_b: NodePath

var packed : PackedScene = preload("res://nodes/chain_segment.tscn")

func _ready():
	var parent = get_node(node_a)
	for i in range(num_chain_segments):
		parent = add_piece(parent)
	var last_joint = parent.get_node("PinJoint2D")
	last_joint.node_a = parent.get_path()
	last_joint.node_b = get_node(node_b).get_path()
	print(last_joint.node_b)
	
func add_piece(parent):
	var child = parent.get_node("PinJoint2D")
	var piece = packed.instantiate()
	child.add_child(piece)
	child.node_a = parent.get_path()
	child.node_b = piece.get_path()
	return piece
	
