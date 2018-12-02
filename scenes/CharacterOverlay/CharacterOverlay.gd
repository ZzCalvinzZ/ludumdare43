extends Node

export (int) var Y_Position
var health = 3
var health_icons = []

func _ready():
	for i in range(1, health + 1):
		var icon = $Health.get_node("HealthSprite" + str(i))
		icon.show()
		health_icons.append(icon)

	pass

func _process(delta):
	pass

func _on_hero_hit():
	health -= 1
	var icon = health_icons.pop()
	icon.hide()
