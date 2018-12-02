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

		if abs(dx) > ATTACK_DISTANCE || abs(dy) > ATTACK_DISTANCE:
			enemy.motion = new_motion.normalized() * MOVE_SPEED
		else:
			self.change_state(enemy.States.Attack)

func process(delta):
	pass
