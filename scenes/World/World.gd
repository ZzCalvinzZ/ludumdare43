extends Node

export (PackedScene) var Enemy1

var hero

var sound_effects
var music

var start_game_sound = preload("res://scenes/TitleScreen/Sound Effects/StartGame.wav")
var main_music_pixelated = preload("res://scenes/World/Music/MainGamePixelated.ogg")
var main_music_modern = preload("res://scenes/World/Music/MainGameModern.ogg")

var light_processed = false

func _ready():
	sound_effects = get_node("SoundEffectsPlayer")
	sound_effects.stream = start_game_sound
	sound_effects.play()

	music = get_node("MusicPlayer")
	music.stream = main_music_pixelated
	music.play()

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
	self.change_music(main_music_pixelated)

func change_music(stream):
	var position = music.get_playback_position()

	if stream == main_music_pixelated:
		AudioServer.set_bus_effect_enabled(2, 0, true)
	else:
		AudioServer.set_bus_effect_enabled(2, 0, false)

	music.stream = stream
	music.play()
	music.seek(position)

