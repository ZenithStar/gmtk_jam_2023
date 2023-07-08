extends Button


# Called when the node enters the scene tree for the first time.
func _pressed():
	GlobalPlayerData.max_level_reached = 0
	GlobalPlayerData.save_values()
	SceneTransition.change_scene(GlobalConstants.level_lookup[0])

