extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var X_SIZE = 640
var Y_SIZE = 640

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	var Enemy1 = preload("res://scenes/Enemy1/Enemy1.tscn")
	var enemy1 = Enemy1.instance()
	add_child(enemy1)

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	pass
