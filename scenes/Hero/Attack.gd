extends "res://scripts/state.gd"

var player
var next_idle = 'idle_down'
var last_press
var sound_effects

var attack_sound = preload("res://scenes/Hero/Sound Effects/AxeSwing.wav")
var axe_hits = [
	preload("res://scenes/Hero/Sound Effects/AxeHit1.wav"),
	preload("res://scenes/Hero/Sound Effects/AxeHit2.wav"),
	preload("res://scenes/Hero/Sound Effects/AxeHit3.wav"),
	preload("res://scenes/Hero/Sound Effects/AxeHit4.wav")	
]

func ready():
	player = self._parent
	sound_effects = get_node('AttackAudioPlayer')


func _process(delta):
	if (Input.is_action_just_pressed('start') &&
		self.get_current_state() != player.States.Attack):

		change_state(player.States.Attack)
		$AttackTimer.start()
		
		if Globals.killable_enemies:
			sound_effects.stream = axe_hits[rand_range(0, len(axe_hits))]
			sound_effects.play()
		else:
			sound_effects.stream = attack_sound
			sound_effects.play()
		
		for enemy in Globals.killable_enemies:
			enemy.kill()


func process(delta):
	pass

func _on_AttackTimer_timeout():
	Globals.player_attack_direction = ''
	change_state(player.States.Idle)
