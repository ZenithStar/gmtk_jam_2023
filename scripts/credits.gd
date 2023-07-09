extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("text_scroll")
	get_node("Timer").timeout.connect(self.timeout)
	pass # Replace with function body.


func timeout():
	SceneTransition.change_scene("res://levels/title_screen.tscn")
