extends Node

export (PackedScene) var Enemy1
export (PackedScene) var Death

var hero

var sound_effects
var music
var selected_music = 'pixelated'

var start_game_sound = preload("res://scenes/TitleScreen/Sound Effects/StartGame.wav")
var rise_sound = preload("res://scenes/World/Sound Effects/Rise.wav")
var fall_sound = preload("res://scenes/World/Sound Effects/Fall.wav")

var musics = {
	'modern': preload("res://scenes/World/Music/MainGameModern.ogg"),
	'pixelated': preload("res://scenes/World/Music/MainGamePixelated.ogg")
}

var light_processed = false

func _ready():
	sound_effects = get_node("SoundEffectsPlayer")
	sound_effects.stream = start_game_sound
	sound_effects.play()

	music = get_node("MusicPlayer")
	music.stream = musics['pixelated']
	music.play()

	randomize()
	$SpawnTimer.start()

func _process(delta):
	hero = $hero

	if !light_processed && Globals.light_scale != null:
		var light = find_node('HeroLight')
		light.scale = Vector2(1,1)

	for enemy in Globals.enemies:
		enemy.update_target(hero)

	if Globals.music != selected_music:
		self.change_music(Globals.music)

func _physics_process(delta):
	pass

func _on_SpawnTimer_timeout():
	$EnemyPath/EnemySpawn.set_offset(randi())
	var enemy = Enemy1.instance()
	Globals.enemies.append(enemy)
	add_child(enemy)
	enemy.position = $EnemyPath/EnemySpawn.position

func _on_hero_hit():
	Globals.health -= 1
	Globals.music = 'pixelated'
	if Globals.health == 0:
		Globals.game_over = true
		var death = Death.instance()
		death.z_index = 10
		add_child(death)
		$DeathTimer.start()

func change_music(music_name):
	Engine.time_scale = 0.2
	$SlowDownTimer.start()
	sound_effects.volume_db = -6
	
	if music_name == 'pixelated':
		sound_effects.stream = fall_sound
		sound_effects.play()
	elif music_name == 'modern':
		sound_effects.stream = rise_sound
		sound_effects.play()
		
	music.stop()
	
	selected_music = music_name
	Globals.music = music_name
	

func _on_DeathTimer_timeout():
	Globals.reset()
	get_tree().change_scene("res://scenes/TitleScreen/TitleScreen.tscn")


func _on_SlowDownTimer_timeout():
	Engine.time_scale = 1
	
	var stream = musics[selected_music]
	var position = music.get_playback_position()

	if stream == musics['pixelated']:
		AudioServer.set_bus_effect_enabled(2, 0, true)
		music.volume_db = 0
	else:
		AudioServer.set_bus_effect_enabled(2, 0, false)
		music.volume_db = 3

	music.stream = stream
	music.play()
	music.seek(position)
