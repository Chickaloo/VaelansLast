extends Node2D

class_name Clock

var time_start = 0
var time_now = 0

func _ready():
	time_start = OS.get_unix_time()
	set_process(true)

func _process(delta):
	time_now = OS.get_unix_time()
	var elapsed = time_now - time_start
	var minutes = elapsed / 60
	var seconds = elapsed % 60
	var str_elapsed = "Time: %02d : %02d" % [minutes, seconds]
	get_node('/root/Level/Camera/TimeDisplay').text = str_elapsed

func getTime():
	return time_now-time_start