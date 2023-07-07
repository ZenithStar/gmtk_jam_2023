extends RigidBody2D

var speed = 400
var facing_left = false

func _process(delta):
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
		facing_left = false
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
		facing_left = true
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
		
	$Sprite2D.flip_h = facing_left

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		position += velocity * delta
