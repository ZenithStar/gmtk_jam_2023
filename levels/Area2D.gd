extends Area2D
signal tire_hit_bottom

func _on_body_entered(body):
	if body is Tire:
		tire_hit_bottom.emit()
