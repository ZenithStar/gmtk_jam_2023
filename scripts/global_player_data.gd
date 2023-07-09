extends Node

var max_level_reached = -1;

func load_next_level():
	max_level_reached = max_level_reached + 1
	save_values()
	SceneTransition.change_scene("res://nodes/victory.tscn")


func load_values():
	var config = ConfigFile.new()
	var err = config.load("user://rodreversal.cfg")
	if err != OK:
		return
	max_level_reached = config.get_value("global_player_data", "max_level_reached")

func save_values():
	var config = ConfigFile.new()
	config.set_value("global_player_data", "max_level_reached", max_level_reached)
	config.save("user://rodreversal.cfg")
	
func _enter_tree():
	load_values()

func _exit_tree():
	save_values()
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
