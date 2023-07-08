extends Button


# Called when the node enters the scene tree for the first time.
func _pressed():
	SceneTransition.change_scene("res://scenes/test_level.tscn")

