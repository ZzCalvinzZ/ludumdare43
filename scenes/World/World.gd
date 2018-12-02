extends Node

export (PackedScene) var Enemy1

var health = 3
var enemies = []
var hero

func _ready():
	randomize()
	$SpawnTimer.start()

func _process(delta):
	hero = $hero

	for enemy in enemies:
		enemy.update_target(hero)

func _physics_process(delta):
	pass

func _on_SpawnTimer_timeout():
	$EnemyPath/EnemySpawn.set_offset(randi())
	var enemy = Enemy1.instance()
	enemies.append(enemy)
	add_child(enemy)
	enemy.position = $EnemyPath/EnemySpawn.position

func _on_hero_hit():
	health -= 1
