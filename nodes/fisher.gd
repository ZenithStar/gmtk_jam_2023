extends RigidBody2D


class_name Fisher


@export var animate_rod = false

var PULL_BACK_ANGLE_DELTA = PI/2
var do_nothing_time = 4
var PULL_BACK_TIME = 2
var THROW_TIME = .2

@onready var start = Time.get_unix_time_from_system()
@onready var shoulder = $FisherContainer/Skeleton2D.get_bone(4)
@onready var start_angle = shoulder.rotation
@onready var pull_back_angle = start_angle + PULL_BACK_ANGLE_DELTA

func do_animate_rod():
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


@export var animate_cigar = false

var C_PULL_BACK_ANGLE_DELTA = 5*PI/8
var C_DO_NOTHING_TIME = 4
var C_PULL_BACK_TIME = .2
var C_THROW_TIME = 2

@onready var c_start = Time.get_unix_time_from_system()
@onready var c_shoulder = $FisherContainer/Skeleton2D.get_bone(7)
@onready var c_start_angle = PI / 5
@onready var c_pull_back_angle = start_angle + C_PULL_BACK_ANGLE_DELTA

func do_animate_cigar():
	var current = Time.get_unix_time_from_system()
	var delta = current - c_start
	if delta < C_DO_NOTHING_TIME:
		# do nothing for a bit
		c_shoulder.rotation = c_start_angle
	elif delta < C_DO_NOTHING_TIME + C_PULL_BACK_TIME:
		# throw the cigar back
		var t = (delta - C_DO_NOTHING_TIME) / C_PULL_BACK_TIME
		c_shoulder.rotation = c_start_angle * (1-t) + pull_back_angle * t
	elif delta < C_DO_NOTHING_TIME + C_PULL_BACK_TIME + C_THROW_TIME:
		# pull out another cigar
		var t = (delta - C_DO_NOTHING_TIME - C_PULL_BACK_TIME) / C_THROW_TIME
		c_shoulder.rotation = c_pull_back_angle * (1-t) + c_start_angle * t
	else:
		# reset
		c_shoulder.rotation = c_start_angle
		c_start = Time.get_unix_time_from_system()

func _process(_delta):
	if animate_rod:
		do_animate_rod()
	if animate_cigar:
		do_animate_cigar()
		

func _ready():
	if !animate_cigar:
		$FisherContainer/skeletons/cigar.visible = false
		
