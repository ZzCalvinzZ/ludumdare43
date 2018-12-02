extends Area2D

var StateMachine = load("res://scripts/state_machine.gd")

var move_direction
var motion = Vector2()
var target
var animator
var state_machine

enum States {
	Chase,
	Attack
}

func _ready():
	animator = get_node('AnimationPlayer')

	state_machine = StateMachine.new(self, States.Chase, animator, {
		Chase: $Chase,
		Attack: $Attack
	})

func _process(delta):
	state_machine.process(delta)
	position += motion * delta

func update_target(new_target):
	target = new_target

func kill():
	print('kill me')
	self.hide()
	Globals.enemies.remove(self)

func chase():
	state_machine.change_states(States.Chase)
