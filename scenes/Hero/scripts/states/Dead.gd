extends "res://scripts/state.gd"

var player

func ready():
	player = self._parent
	set_animation('death')

func process(delta):
	set_animation('death')
