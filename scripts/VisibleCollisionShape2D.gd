@tool
extends CollisionShape2D
class_name VisibleCollisionShape2D

@export var color: Color = Color("000000")

# Called when the node enters the scene tree for the first time.
func _ready():
	queue_redraw()

func _draw():
	if (shape is CircleShape2D):
		draw_circle(Vector2(0, 0), shape.radius, color)
	elif (shape is CapsuleShape2D):
		var actual_height = shape.height - shape.radius
		if actual_height < 0.0:
			draw_circle(Vector2(0, 0), shape.radius, color)
		else:
			draw_circle(Vector2(0, 0.5 * actual_height), shape.radius, color)
			draw_circle(Vector2(0,-0.5 * actual_height), shape.radius, color)
			draw_rect(Rect2(Vector2(-shape.radius, -0.5*actual_height), Vector2( 2.0 * shape.radius, actual_height )), color)
