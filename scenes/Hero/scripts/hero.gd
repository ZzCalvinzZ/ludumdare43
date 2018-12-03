extends Area2D

signal hit

var StateMachine = load("res://scripts/state_machine.gd")

var deadzone = 0.5
var motion = Vector2()
var next_idle = 'idle_down'

var animator
var sound_effects
var sprite

var ouches = [
	preload("res://scenes/Hero/Sound Effects/Ouch1.wav"),
	preload("res://scenes/Hero/Sound Effects/Ouch2.wav"),
	preload("res://scenes/Hero/Sound Effects/Ouch3.wav"),
	preload("res://scenes/Hero/Sound Effects/Ouch4.wav"),
	preload("res://scenes/Hero/Sound Effects/Ouch5.wav")
]
var death = preload("res://scenes/Hero/Sound Effects/Death.wav")

var state_machine

enum States {
	Idle,
	Move,
	Attack,
	Dead,
}

func _ready():
	animator = get_node('AnimationPlayer')
	sound_effects = get_node('AudioStreamPlayer')

	state_machine = StateMachine.new(self, Idle, animator, {
		Idle: get_node('Idle'),
		Move: get_node('Move'),
		Attack: get_node('Attack'),
		Dead: get_node('Dead'),
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

		state_machine.change_state(States.Dead)

		if Globals.health <= 0:
			sound_effects.stream = death

			sound_effects.play()
		else:
			sound_effects.stream = ouches[rand_range(0, len(ouches))]
			sound_effects.play()
