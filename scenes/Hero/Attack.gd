extends "res://scripts/state.gd"

var player
var next_idle = 'idle_down'
var last_press


func ready():
	player = self._parent


func _process(delta):
	if (Input.is_action_just_pressed('start') &&
		self.get_current_state() != player.States.Attack):

		change_state(player.States.Attack)
		$AttackTimer.start()
		
		for enemy in Globals.killable_enemies:
			enemy.kill()


func process(delta):
	pass

func _on_AttackTimer_timeout():
	Globals.player_attack_direction = ''
	change_state(player.States.Idle)
