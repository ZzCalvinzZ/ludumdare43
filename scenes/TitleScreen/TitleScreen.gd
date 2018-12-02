extends Node

var animator
var lowpass

var CUTOFF_MIN = 1000
var CUTOFF_MAX = 3000
var cutoff = CUTOFF_MIN
var cutoff_dir = 1
export (float) var cutoff_multiplier = 50

var highlighted_sacrifice = 0
var sacrifices

var sound_effects
var select_sacrifice_sound = preload("res://scenes/TitleScreen/Sound Effects/SelectSacrifice.wav")


func _input(event):
	if event.is_action_pressed('start'):
		Globals.selected_sacrifice = sacrifices[highlighted_sacrifice].name
		if Globals.selected_sacrifice == "Heart":
			Globals.health = 1
		else:
			Globals.health = 3

		if Globals.selected_sacrifice == "Legs":
			Globals.speed = 100

		if Globals.selected_sacrifice == "Eyes":
			Globals.light_scale = 1

		get_tree().change_scene("res://scenes/World/World.tscn")


	if event.is_action_pressed('left'):
		highlighted_sacrifice -= 1
		self.select_sacrifice()

		if highlighted_sacrifice < 0:
			highlighted_sacrifice = len(sacrifices) - 1

	elif event.is_action_pressed('right'):
		highlighted_sacrifice += 1
		self.select_sacrifice()

		if highlighted_sacrifice > len(sacrifices) - 1:
			highlighted_sacrifice = 0


func _ready():
	animator = find_node("AnimationPlayer")
	sound_effects = get_node("SoundEffectsPlayer")
	animator.play("pulse")

	lowpass = AudioServer.get_bus_effect(1, 0)
	lowpass.cutoff_hz = cutoff

	sacrifices = [
		find_node("Heart"),
		find_node("Legs"),
		find_node("Eyes")
	]


func _process(delta):
	lowpass.cutoff_hz = cutoff
	cutoff += cutoff_dir * delta * cutoff_multiplier

	if cutoff > CUTOFF_MAX:
		cutoff_dir = -1
	if cutoff < CUTOFF_MIN:
		cutoff_dir = 1

	for sacrifice in sacrifices:
		sacrifice.highlighted = false

	sacrifices[highlighted_sacrifice].highlighted = true


func select_sacrifice():
	sound_effects.stream = select_sacrifice_sound
	sound_effects.play()
