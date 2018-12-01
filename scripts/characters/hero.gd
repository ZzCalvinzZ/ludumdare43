extends KinematicBody2D

var StateMachine = load("res://Scripts/state_machine.gd")

var deadzone = 0.5
var motion = Vector2()
var MOVE_SPEED = 250

var animator
var sprite

var state_machine

enum States {
	IdleDown,
	IdleLeft,
	IdleRight,
	IdleUp,
	MoveDown,
	MoveLeft,
	MoveRight,
	MoveUp
}

func _input(event):
	if event.is_action("up"):
		print('up')
	if event.is_action("right"):
		print('right')
	if event.is_action_pressed("down"):
		print('down')
	if event.is_action_pressed("left"):
		print('left')

func _ready():
	animator = find_node('AnimationPlayer')
	state_machine = StateMachine.new(self, IdleDown, animator, {
		IdleDown: find_node("IdleDown"),
		IdleLeft: find_node("Idleleft"),
		IdleRight: find_node("IdleRight"),
		IdleUp: find_node("IdleUp"),
		MoveDown: find_node("MoveDown"),
		MoveLeft: find_node("MoveLeft"),
		MoveRight: find_node("MoveRight"),
		MoveUp: find_node("MoveUp"),
	})

	sprite = find_node("Sprite")


func _process(delta):
	state_machine.process(delta)


func _physics_process(delta):
	state_machine.physics_process(delta)

# 	motion.y = delta + 10 * GRAVITY

# 	move_and_slide(motion)

func get_movement():
	# var x = Input.get_joy_axis(0, 0)

	# if abs(x) > deadzone:
	# 	return x * move_speed

	# return 0

func move(x):
	# motion.x = x
