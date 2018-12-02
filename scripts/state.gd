extends Node

var _animation = ""
var _animator
var _parent
var _state_machine
var _animation_finished_state = null

func init(state_machine, parent, animator):
	_animator = animator
	_parent = parent
	_state_machine = state_machine

func get_states():
	return _state_machine._states

func get_current_state():
	return _state_machine._current_state

func state_changed():
	_animator.play(_animation)

	if _animation_finished_state != null:
		yield(_animator, "animation_finished")
		self.change_state(_animation_finished_state)

func change_state(new_state):
	_state_machine.change_state(new_state)

func set_animation(animation, finished_state=null):
	var old_animation = _animation
	_animation = animation
	self._animation_finished_state = finished_state

	if old_animation != _animation:
		self.state_changed()


# Called when state is initialized and properties are set
func ready():
	pass

# Called when receiving input
func input(event):
	pass

# Called once per frame
func process(delta):
	pass

# Called in consistent intervals
func physics_process(delta):
	pass
