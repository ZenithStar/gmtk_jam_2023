extends Node2D


func _handle_victory():
	print("VICTORY!")
	# TODO: monique to write code here!
	pass


func _on_area_2d_body_entered(body):
	if body is Tire:
		_handle_victory()
