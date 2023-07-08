extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	var currentLevelToContinueAt = GlobalPlayerData.max_level_reached
	var levels = GlobalConstants.level_lookup
	get_node("BottomBar/CurrentLevel").text = "Current Level: " +str(currentLevelToContinueAt+1)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
