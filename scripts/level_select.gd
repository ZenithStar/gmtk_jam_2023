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
		var is_last_item = level_number == levels.size()
		var button_text = "Credits" if is_last_item else "Level: " + str(level_number)
		var is_button_disabled = false if is_last_item else currentLevelToContinueAt + 1 < level_number 
		var level_button = Button.new()
		level_button.text = button_text
		level_button.set_position(Vector2(x,y))
		level_button.disabled = is_button_disabled
		level_button.pressed.connect(self.custom_button_pressed(level_number))
			
		add_child(level_button)

func custom_button_pressed(level_number):
	return func button_pressed_with_level_number():
		get_tree().change_scene_to_file(GlobalConstants.level_lookup[level_number-1])
