extends Control

@onready var scene_tree_ref = get_tree()
var paused = false

func _ready():
	set_paused(paused)
	
func _unhandled_input(event):
	if event.is_action_pressed("pause"):
		print("got to pause button")
		self.set_paused(!paused)
		get_viewport().set_input_as_handled()

func set_paused(is_paused):
	print("got to set paused")
	print(is_paused)
	paused = is_paused
	scene_tree_ref.paused = is_paused
	get_node("PauseOverlay").visible = is_paused
