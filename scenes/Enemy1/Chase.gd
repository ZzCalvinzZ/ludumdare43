extends "res://scripts/state.gd"

var enemy
export (int) var MOVE_SPEED
export (int) var ATTACK_DISTANCE

func ready():
	enemy = self._parent

func _process(delta):
	if !self.get_current_state() == enemy.States.Chase:
		return

	var target = enemy.target

	enemy.motion = Vector2()

	if (target):
		var dx = target.position.x - enemy.position.x
		var dy = target.position.y - enemy.position.y
		var new_motion = Vector2(dx, dy)

		var plane = 'leftright' if abs(dx) > abs(dy) else 'updown'
		var dir

		if plane == 'leftright':
			if dx > 0:
				enemy.next_idle = 'idle_right'
				set_animation('move_right')
			else:
				enemy.next_idle = 'idle_left'
				set_animation('move_left')
		else:
			if dy > 0:
				enemy.next_idle = 'idle_down'
				set_animation('move_down')
			else:
				enemy.next_idle = 'idle_up'
				set_animation('move_up')

		if abs(dx) > ATTACK_DISTANCE || abs(dy) > ATTACK_DISTANCE:
			enemy.motion = new_motion.normalized() * MOVE_SPEED
		else:
			self.change_state(enemy.States.Attack)

func process(delta):
	pass
