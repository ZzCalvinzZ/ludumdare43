extends Node2D

var enemy

func ready():
	enemy = self._parent
	set_animation("move_left")

func _process(delta):
	if (Input.is_action_pressed('up') ||
		Input.is_action_pressed('right') ||
		Input.is_action_pressed('down') ||
		Input.is_action_pressed('left')):
		change_state(player.States.Move)

	var motion = Vector2()

	if Input.is_action_pressed('up'):
		motion.y -= 1
	if Input.is_action_pressed('right'):
		motion.x += 1
	if Input.is_action_pressed('down'):
		motion.y += 1
	if Input.is_action_pressed('left'):
		motion.x -= 1

	if motion.x > 0:
		next_idle = 'idle_right'
		set_animation('move_right')
	elif motion.x < 0:
		next_idle = 'idle_left'
		set_animation('move_left')
	elif motion.y > 0:
		next_idle = 'idle_down'
		set_animation('move_down')
	elif motion.y < 0:
		next_idle = 'idle_up'
		set_animation('move_up')

	motion = motion.normalized() * player.MOVE_SPEED
	player.set_motion(motion, next_idle)

	if motion.x == 0 && motion.y == 0:
		self.change_state(player.States.Idle)

func process(delta):
	pass

