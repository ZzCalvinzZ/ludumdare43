extends Area2D

signal hit

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
	Attack,
}

func _ready():
	animator = get_node('AnimationPlayer')
	state_machine = StateMachine.new(self, Idle, animator, {
		Idle: get_node('Idle'),
		Move: get_node('Move'),
		Attack: get_node('Attack'),
	})

	sprite = find_node("Sprite")


func _process(delta):
	state_machine.process(delta)
	position += motion * delta

func set_motion(motion, next_idle):
	self.next_idle = next_idle
	self.motion = motion

func _on_hero_area_entered(area):
	if area.name.find('Enemy1') > -1:
		emit_signal('hit')
