extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("fly_across_screen")
	get_node("Timer").timeout.connect(self.timeout)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func timeout():
	SceneTransition.change_scene(GlobalConstants.level_lookup[GlobalPlayerData.max_level_reached])
