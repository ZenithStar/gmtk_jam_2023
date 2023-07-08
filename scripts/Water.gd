@tool
extends Area2D
class_name Water

@export var collision_size : Vector2 = Vector2(128,128)

func _ready():
	$CollisionShape2D.shape.size = collision_size
	$Sprite2D.apply_scale( collision_size / Vector2(128,128) )
	

func _on_body_entered(body):
	print(body, 'entered water')
	if body is Bouyant:
		body.set_submerged(true)

func _on_body_exited(body):
	print(body, 'exited water')
	if body is Bouyant:
		body.set_submerged(false)
