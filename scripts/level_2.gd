extends Node2D


@export var cigar_scene: PackedScene


func _handle_victory():
	print("VICTORY!")
	GlobalPlayerData.load_next_level()
	pass


func _ready():
	$StartCigars.start()

func on_barrel_collide(body):
	if body is Cigar:
		$VictoryTimer.start()
		# animate explosion


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
