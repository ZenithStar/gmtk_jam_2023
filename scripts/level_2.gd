extends Node2D


@export var cigar_scene: PackedScene


func _handle_victory():
	print("VICTORY!")
	GlobalPlayerData.load_next_level()
	pass


func _ready():
	$Explosion.visible = false
	$StartCigars.start()

func on_barrel_collide(body):
	if body is Cigar:
		$VictoryTimer.start()
		$Explosion.position = $OilDrum.position
		$Explosion.visible = true
		$OilDrum.visible = false
		$Explosion.play()
		$explosion1.play()
		$Boat.apply_impulse(Vector2(-200000, 200000))


func on_victory_timer_expire():
	_handle_victory()


func on_start_cigars():
	spawn_cigar()
	$SpawnCigarTimer.start()
	

func on_spawn_cigar_timer():
	spawn_cigar()


func spawn_cigar():
	var cigar = cigar_scene.instantiate()
	var pos = $Boat.position
	pos.x += 500
	pos.y -= 150
	cigar.position = pos
	cigar.rotation = randf() * 2 * PI
	add_child(cigar)
