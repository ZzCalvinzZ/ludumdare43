extends Node

export (PackedScene) var Enemy1

var hero

var sound_effects
var music
var selected_music

var start_game_sound = preload("res://scenes/TitleScreen/Sound Effects/StartGame.wav")

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
	self.change_music('pixelated')

	randomize()
	$SpawnTimer.start()

func _process(delta):
	hero = $hero

	if !light_processed && Globals.light_scale != null:
		var light = find_node('HeroLight')
		print(light.scale)
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

func change_music(music_name):
	selected_music = music_name
	Globals.music = music_name
	var stream = musics[music_name]
	var position = music.get_playback_position()

	if stream == musics['pixelated']:
		AudioServer.set_bus_effect_enabled(2, 0, true)
	else:
		AudioServer.set_bus_effect_enabled(2, 0, false)

	music.stream = stream
	music.play()
	music.seek(position)

