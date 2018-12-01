extends "res://scripts/state.gd"

var player

func ready():
	player = self._parent
	set_animation(player.next_idle)
	
func process(delta):
	set_animation(player.next_idle)
