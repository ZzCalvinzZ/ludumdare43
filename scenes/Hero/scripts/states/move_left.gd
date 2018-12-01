extends "res://scripts/state.gd"

var player

func ready():
	player = self._parent
	set_animation("move_left")
	
func process(delta):
	if player.motion.x == 0 && player.motion.y == 0:
		self.change_state(player.States.IdleLeft)
