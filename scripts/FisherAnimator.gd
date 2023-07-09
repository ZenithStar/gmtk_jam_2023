extends Node2D


var PULL_BACK_ANGLE_DELTA = PI/2
var do_nothing_time = 4
var PULL_BACK_TIME = 2
var THROW_TIME = .2

@onready var start = Time.get_unix_time_from_system()
@onready var shoulder = $Skeleton2D.get_bone(4)
@onready var start_angle = shoulder.rotation
@onready var pull_back_angle = start_angle + PULL_BACK_ANGLE_DELTA


func _process(_delta):
	"""
	var current = Time.get_unix_time_from_system()
	var delta = current - start
	if delta < do_nothing_time:
		# do nothing for a bit
		pass
	elif delta < do_nothing_time + PULL_BACK_TIME:
		# pull the rod back
		var t = (delta - do_nothing_time) / PULL_BACK_TIME
		shoulder.rotation = start_angle * (1-t) + pull_back_angle * t
	elif delta < do_nothing_time + PULL_BACK_TIME + THROW_TIME:
		# throw the rod forward
		var t = (delta - do_nothing_time - PULL_BACK_TIME) / THROW_TIME
		shoulder.rotation = pull_back_angle * (1-t) + start_angle * t
	else:
		# reset
		shoulder.rotation = start_angle
		start = Time.get_unix_time_from_system()
		do_nothing_time = 2 + randi() % 5
	"""
