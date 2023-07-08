extends Area2D
class_name Water

func _ready():
	$Sprite2D.apply_scale( $CollisionShape2D.shape.size / Vector2(128,128) )
	print($Sprite2D.scale)

func _on_body_entered(body):
	if body is Buoyant:
		body.set_submerged(true)

func _on_body_exited(body):
	if body is Buoyant:
		body.set_submerged(false)
