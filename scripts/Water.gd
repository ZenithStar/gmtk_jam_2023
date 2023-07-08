extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	var area_size = $CollisionShape2D.shape.size
	$Sprite2D.apply_scale(area_size / Vector2(128,128))
