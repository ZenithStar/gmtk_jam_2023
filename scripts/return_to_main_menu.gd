extends Button


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _pressed():
	print("got to pressed return to main menu button")
	get_tree().paused = false
	SceneTransition.change_scene("res://levels/title_screen.tscn")
