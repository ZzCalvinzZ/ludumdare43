extends Node

export (PackedScene) var Enemy1

var health = 3
var hero
var sound_effects

var start_game_sound = preload("res://scenes/TitleScreen/Sound Effects/StartGame.wav")

func _ready():
	sound_effects = get_node("SoundEffectsPlayer")
	sound_effects.stream = start_game_sound
	sound_effects.play()
	randomize()
	$SpawnTimer.start()

func _process(delta):
	hero = $hero

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
	health -= 1
