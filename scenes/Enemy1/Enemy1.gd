extends KinematicBody2D

var StateMachine = load("res://scripts/state_machine.gd")

var move_direction
export (int) var MOVE_SPEED
var motion = Vector2()
var target

var state_machine

enum States {
	Idle,
	Move,
}

func _ready():
	pass
	# state_machine = StateMachine.new(self, Idle, animator, {
	# 	Idle: $Idle,
	# 	Move: $Move,
	# })

func _process(delta):
	pass
	# state_machine.process(delta)

func update_target(new_target):
	target = new_target

func chase():
	var new_motion = Vector2()

	if (target):
		var dx = self.position.x - target.position.x
		var dy = self.position.y - target.position.y
		var absdx = abs(dx)
		var absdy = abs(dy)

		print('dx',dx)
		print('dy',dy)
		print('absdx', absdx)
		print('absdy', absdy)

		if absdx > 50 || absdy > 50:
			var dir = 'leftright' if absdx > absdy else 'updown'

			if dir == 'leftright':
				if dx > 0:
					new_motion.x -= 1
				else:
					new_motion.x += 1
			elif dir == 'updown':
				if dy > 0:
					new_motion.y -= 1
				else:
					new_motion.y += 1

		motion = new_motion.normalized() * MOVE_SPEED
		move_and_slide(motion)

func _physics_process(delta):
	chase()
	# state_machine.physics_process(delta)
