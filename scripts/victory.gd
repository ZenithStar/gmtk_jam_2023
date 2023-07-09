extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("fly_across_screen")
	$AnimationPlayer2.play("barral_fly")
	$AnimationPlayer3.play("cooler_fly")
	$AnimationPlayer4.play("shark_fly")
	get_node("Timer").timeout.connect(self.timeout)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func timeout():
	SceneTransition.change_scene(GlobalConstants.level_lookup[GlobalPlayerData.max_level_reached])
