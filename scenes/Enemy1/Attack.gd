extends "res://scripts/state.gd"

var enemy
var initial_target_position
enum Phases {
	BackingUp,
	Attacking,
	FinalPause,
}
var phase = null

export (int) var BACKUP_SPEED
export (int) var ATTACK_SPEED

func ready():
	enemy = self._parent

func _process(delta):
	if !self.get_current_state() == enemy.States.Attack:
		return

	var target = enemy.target

	enemy.motion = Vector2()

	if target:
		if phase == null:
			phase = Phases.BackingUp
			initial_target_position = target.position
			$BackupTimer.start()

		var dx = initial_target_position.x - enemy.position.x
		var dy = initial_target_position.y - enemy.position.y
		var new_motion = Vector2(dx, dy)

		if phase == Phases.BackingUp:
			enemy.motion = new_motion.rotated(PI).normalized() * BACKUP_SPEED
		elif phase == Phases.Attacking:
			enemy.motion = new_motion.normalized() * ATTACK_SPEED
		elif phase == Phases.FinalPause:
			pass

func process(delta):
	pass

func _on_BackupTimer_timeout():
	phase = Phases.Attacking
	$AttackTimer.start()

func _on_AttackTimer_timeout():
	phase = Phases.FinalPause
	$PauseTimer.start()

func _on_PauseTimer_timeout():
	phase = null
	self.change_state(enemy.States.Chase)

