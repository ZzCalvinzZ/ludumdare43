extends "res://scripts/state.gd"

var enemy

func ready():
	enemy = self._parent
	set_animation('death')

func process(delta):
	set_animation('death')
