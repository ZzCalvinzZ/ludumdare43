extends Node

var animator

func _input(event):
	if event.is_action_pressed('start'):
		get_tree().change_scene("res://scenes/World/World.tscn")


func _ready():
	animator = find_node("AnimationPlayer")
	animator.play("pulse")

func _process(delta):
	pass
