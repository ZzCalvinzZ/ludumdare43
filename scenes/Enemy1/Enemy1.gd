extends KinematicBody2D

var StateMachine = load("res://scripts/state_machine.gd")

var move_direction
var motion = Vector2()
var target
var animator
var state_machine

enum States {
	Chase,
	# Circle,
	Attack
}

func _ready():
	animator = get_node('AnimationPlayer')

	state_machine = StateMachine.new(self, States.Chase, animator, {
		Chase: $Chase,
		# Circle: $Circle,
		Attack: $Attack
	})

func _process(delta):
	state_machine.process(delta)

func update_target(new_target):
	target = new_target

func chase():
	state_machine.change_states(States.Chase)

func _physics_process(delta):
	move_and_slide(motion)
	state_machine.physics_process(delta)
