extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	var x_padding = 100;
	var y_padding = 100;
	
	var currentLevelToContinueAt = GlobalPlayerData.max_level_reached
	var levels = GlobalConstants.level_lookup
	
	for index in range(levels.size()):
		var level_number = index+1
		var x = ((index % 5) * 240) + x_padding
		var y = ((index / 5) * 100) + y_padding
		var level_button = Button.new()
		level_button.text = "Level: " + str(level_number)
		level_button.set_position(Vector2(x,y))
		level_button.disabled = currentLevelToContinueAt + 1 < level_number
		level_button.pressed.connect(self.custom_button_pressed(level_number))
			
		add_child(level_button)

func custom_button_pressed(level_number):
	return func button_pressed_with_level_number():
		get_tree().change_scene_to_file(GlobalConstants.level_lookup[level_number-1])
