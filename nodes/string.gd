extends Node2D
class_name String2D

@export var ropeLength = 50
@export var constrain = 1	# distance between points
@export var gravity = Vector2(0,9.8)
@export var dampening = 0.9
@export var startPin = true
@export var endPin = true
@export var endOffset = Vector2(100, 0)

@onready var line2D: = $Line2D
@onready var bobber: = $Bobber

var pos: PackedVector2Array
var posPrev: PackedVector2Array
var pointCount: int

func _ready()->void:
	print("_ready()")
	pointCount = get_pointCount(ropeLength)
	print("Rigid:", bobber)
	print("line2D:", line2D)
	resize_arrays()
	init_position()

func get_pointCount(distance: float)->int:
	return int(ceil(distance / constrain))

func resize_arrays():
	pos.resize(pointCount)
	posPrev.resize(pointCount)

func init_position()->void:
	for i in range(pointCount):
		var offset = endOffset * ((0.0+i) / pointCount)
		pos[i] = position + offset
		posPrev[i] = pos[i]
	position = Vector2.ZERO

func _unhandled_input(event:InputEvent)->void:
	if event is InputEventMouseMotion:
		if Input.is_action_pressed("click"):	#Move start point
			set_start(get_global_mouse_position())
		if Input.is_action_pressed("right_click"):	#Move start point
			set_last(get_global_mouse_position())
	elif event is InputEventMouseButton && event.is_pressed():
		if event.button_index == 1:
			set_start(get_global_mouse_position())
		elif event.button_index == 2:
			set_last(get_global_mouse_position())

func _process(delta)->void: #delta is typically 0.016...
	update_points(delta)
	update_constrain()
	if (bobber != null):
		set_last(bobber.transform.origin)
	
	#update_constrain()	#Repeat to get tighter rope
	#update_constrain()
	
	# Send positions to Line2D for drawing
	line2D.points = pos

func set_start(p:Vector2)->void:
	pos[0] = p
	posPrev[0] = p

func set_last(p:Vector2)->void:
	pos[pointCount-1] = p
	posPrev[pointCount-1] = p

func update_points(delta)->void:
	for i in range (pointCount):
		# not first and last || first if not pinned || last if not pinned
		if (i!=0 && i!=pointCount-1) || (i==0 && !startPin) || (i==pointCount-1 && !endPin):
			var velocity = (pos[i] -posPrev[i]) * dampening
			posPrev[i] = pos[i]
			pos[i] += velocity + (gravity * delta)

func update_constrain()->void:
	for i in range(pointCount):
		if i == pointCount-1:
			return
		var distance = pos[i].distance_to(pos[i+1])
		var difference = constrain - distance
		var percent = difference / distance
		var vec2 = pos[i+1] - pos[i]
		
		# if first point
		if i == 0:
			if startPin:
				pos[i+1] += vec2 * percent
			else:
				pos[i] -= vec2 * (percent/2)
				pos[i+1] += vec2 * (percent/2)
		# if last point, skip because no more points after it
		elif i == pointCount-1:
			pass
		# all the rest
		else:
			if i+1 == pointCount-1 && endPin:
				pos[i] -= vec2 * percent
			else:
				pos[i] -= vec2 * (percent/2)
				pos[i+1] += vec2 * (percent/2)
