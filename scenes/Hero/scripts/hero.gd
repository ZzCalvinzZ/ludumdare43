extends KinematicBody2D

var StateMachine = load("res://scripts/state_machine.gd")

var deadzone = 0.5
var motion = Vector2()
var MOVE_SPEED = 250

var animator
var sprite

var state_machine

enum States {
	#IdleDown,
	IdleLeft,
	#IdleRight,
	#IdleUp,
	#MoveDown,
	MoveLeft,
	#MoveRight,
	#MoveUp
}

func _input(event):
	motion = Vector2()
	
	if event.is_action("up"):
		state_machine.change_state(States.MoveUp)
		motion.y -= 1
	if event.is_action("right"):
		state_machine.change_state(States.MoveRight)
		motion.x += 1
	if event.is_action_pressed("down"):
		state_machine.change_state(States.MoveDown)
		motion.y += 1
	if event.is_action_pressed("left"):
		state_machine.change_state(States.MoveLeft)
		motion.x -= 1
		
	motion = motion.normalized() * MOVE_SPEED

func _ready():
	animator = get_node('AnimationPlayer')

	state_machine = StateMachine.new(self, IdleLeft, animator, {
		#IdleDown: find_node("IdleDown"),
		IdleLeft: get_node('IdleLeft'),
		#IdleRight: find_node("IdleRight"),
		#IdleUp: find_node("IdleUp"),
		#MoveDown: find_node("MoveDown"),
		MoveLeft: get_node('MoveLeft'),
		#MoveRight: find_node("MoveRight"),
		#MoveUp: find_node("MoveUp"),
	})

	sprite = find_node("Sprite")


func _process(delta):
	state_machine.process(delta)


func _physics_process(delta):
	state_machine.physics_process(delta)
	move_and_slide(motion)

