extends Node2D


func _handle_victory():
	print("VICTORY!")
	GlobalPlayerData.load_next_level()
	pass


func _on_area_2d_body_entered(body):
	if body is Fisher:
		_handle_victory()
