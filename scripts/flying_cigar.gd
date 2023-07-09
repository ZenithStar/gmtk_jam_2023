extends Buoyant

class_name Cigar

func _ready():
	print('cigar spawned!')
	$Timer.start()
	
func on_timer_expire():
	# delete self
	print('cigar died!')
	queue_free()
