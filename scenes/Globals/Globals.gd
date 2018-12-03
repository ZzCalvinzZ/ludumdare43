extends Node

var selected_sacrifice = null
var player_attack_direction = null
var enemies = []
var killable_enemies = []
var health = null
var speed = 250
var light_scale = null
var music = null
var game_over = false

func reset():
	selected_sacrifice = null
	player_attack_direction = null
	enemies = []
	killable_enemies = []
	health = null
	speed = 250
	light_scale = null
	game_over = false


func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

