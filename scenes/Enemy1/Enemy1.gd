extends Area2D

var StateMachine = load("res://scripts/state_machine.gd")

var move_direction
var motion = Vector2()
var target
var animator
var state_machine
var audio_stream

var swing_sound = preload("res://scenes/Enemy1/Sound Effects/Swing.wav")
var attack_zone = ''

enum States {
	Chase,
	Attack
}

func _ready():
	animator = get_node('AnimationPlayer')
	audio_stream = get_node('AudioStreamPlayer')

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
	self.hide()
	self.set_process(false)
	self.queue_free()
	Globals.enemies.erase(self)
	Globals.killable_enemies.erase(self)
	Globals.music = 'modern'

func chase():
	state_machine.change_states(States.Chase)
	
func play_attack_sound():
	audio_stream.stream = swing_sound
	audio_stream.volume_db = 6
	audio_stream.play()

