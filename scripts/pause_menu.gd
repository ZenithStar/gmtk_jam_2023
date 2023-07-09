extends Control

@onready var scene_tree_ref = get_tree()
var paused = false

func _ready():
	set_paused(paused)
	get_node("PauseOverlay/ResumeGame").pressed.connect(self.resume_game)
	get_node("PauseOverlay/ReturnToMainMenu").pressed.connect(self.return_to_main_menu)
	get_node("PauseOverlay/CurrentLevelLabel").text = get_node("PauseOverlay/CurrentLevelLabel").text.replace("%s", str(GlobalPlayerData.max_level_reached+1))
	
func _unhandled_input(event):
	if event.is_action_pressed("pause"):
		self.set_paused(!paused)
		get_viewport().set_input_as_handled()

func set_paused(is_paused):
	paused = is_paused
	scene_tree_ref.paused = is_paused
	get_node("PauseOverlay").visible = is_paused
	
func resume_game():
	set_paused(false)
	
func return_to_main_menu():
	scene_tree_ref.paused = false
	SceneTransition.change_scene("res://levels/title_screen.tscn")
