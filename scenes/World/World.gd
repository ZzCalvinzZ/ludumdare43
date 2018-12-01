extends Node

export (PackedScene) var Enemy1
export (PackedScene) var Hero

func _ready():
	randomize()
	$SpawnTimer.start()
	var hero = Hero.instance()
	add_child(hero)
	

func _process(delta):
	pass

func _on_SpawnTimer_timeout():
	$EnemyPath/EnemySpawn.set_offset(randi())
	var enemy = Enemy1.instance()
	add_child(enemy)
	enemy.position = $EnemyPath/EnemySpawn.position
