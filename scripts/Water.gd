extends Area2D
class_name Water

func _ready():
	$Sprite2D.apply_scale( $CollisionShape2D.shape.size / Vector2(128,128) )
	print($Sprite2D.scale)

func _on_body_entered(body):
	print(body, 'entered water')
	if body is Buoyant:
		body.set_submerged(true)

func _on_body_exited(body):
	print(body, 'exited water')
	if body is Buoyant:
		body.set_submerged(false)
