extends KinematicBody2D

var StateMachine = load("res://scripts/state_machine.gd")

var deadzone = 0.5
var motion = Vector2()
var next_idle = 'idle_down'
export (int) var MOVE_SPEED = 250

var animator
var sprite

var state_machine

enum States {
	Idle,
	Move,
}

func _ready():
	animator = get_node('AnimationPlayer')

	state_machine = StateMachine.new(self, Idle, animator, {
		Idle: get_node('Idle'),
		Move: get_node('Move'),
	})

	sprite = find_node("Sprite")
	

func _process(delta):
	state_machine.process(delta)
	
	
func set_motion(motion, next_idle):
	self.next_idle = next_idle
	self.motion = motion


func _physics_process(delta):
	state_machine.physics_process(delta)
	move_and_slide(motion)

