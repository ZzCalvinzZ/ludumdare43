extends "res://scripts/state.gd"

var player

func ready():
	player = self._parent
	set_animation("idle_left")
	
func process(delta):
	pass
