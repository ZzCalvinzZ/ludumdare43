extends Node

var animator
var lowpass

var CUTOFF_MIN = 1000
var CUTOFF_MAX = 3000
var cutoff = CUTOFF_MIN
var cutoff_dir = 1
export (float) var cutoff_multiplier = 50

func _input(event):
	if event.is_action_pressed('start'):
		get_tree().change_scene("res://scenes/World/World.tscn")


func _ready():
	animator = find_node("AnimationPlayer")
	animator.play("pulse")
	
	lowpass = AudioServer.get_bus_effect(1, 0)
	lowpass.cutoff_hz = cutoff

func _process(delta):
	lowpass.cutoff_hz = cutoff
	cutoff += cutoff_dir * delta * cutoff_multiplier
	
	if cutoff > CUTOFF_MAX:
		cutoff_dir = -1
	if cutoff < CUTOFF_MIN:
		cutoff_dir = 1
		
