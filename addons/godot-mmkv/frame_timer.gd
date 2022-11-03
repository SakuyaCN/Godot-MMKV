class_name FrameTimer
extends Node

export var wait_time: float = 1
export var one_shot: bool = false
export var auto_start: bool = false
var start_time: float = 0
var time_left: float = 0
var ratio: float = 0

var running = false

signal timeout(amount)

func _ready():
	set_process(false)
	if auto_start:
		start()

func start():
	start_time = OS.get_ticks_msec()
	running = true
	set_process(true)

func stop():
	set_process(false)
	running = false
	time_left = 0

func _process(_delta):
	var current_time = OS.get_ticks_msec()
	
	var diff = current_time - start_time
	var diff_sec = diff / 1000.0

	var amount = floor(float(diff_sec) / float(wait_time))
	
	time_left = clamp(float(wait_time) - float(diff_sec), 0.0, INF)
	if !is_equal_approx(time_left, 0):
		ratio = 1.0 - (float(time_left) / float(wait_time))
	else:
		ratio = 1.0

	if amount >= 1:
		start_time = OS.get_ticks_msec()
		emit_signal("timeout", amount)
		if one_shot:
			stop()
