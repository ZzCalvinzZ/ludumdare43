extends "res://scripts/state.gd"

var player
var next_idle = 'idle_down'
var last_press
var attacking = true


func ready():
	player = self._parent


func _process(delta):
	if (Input.is_action_just_pressed('start') &&
		self.get_current_state() != player.States.Attack):

		change_state(player.States.Attack)
		print('attacking')
		$AttackTimer.start()
		attacking = true

	if attacking:
		# var node

		# if player.next_idle == 'idle_up':
		# 	node = $AttackUp
		# elif player.next_idle == 'idle_right':
		# 	node = $AttackRight
		# elif player.next_idle == 'idle_down':
		# 	node = $AttackDown
		# elif player.next_idle == 'idle_left':
		# 	node = $AttackLeft

		for enemy in Globals.enemies:
			for node in [$AttackLeft, $AttackRight, $AttackUp, $AttackDown]:
				if node && node.overlaps_area(enemy):
					print('kiillliinnng')
					print(enemy)
					enemy.kill()

func process(delta):
	pass

func _on_AttackTimer_timeout():
	print('timeout done')
	attacking = false
	change_state(player.States.Idle)
