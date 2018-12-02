extends Node

export (int) var Y_Position
var health = 3
var health_icons = []
var selected_sacrifice
var sacrifices

func _ready():
	for i in range(1, health + 1):
		var icon = $Health.get_node("HealthSprite" + str(i))
		icon.show()
		health_icons.append(icon)

	sacrifices = {
		'Heart': find_node('Heart'),
		'Legs': find_node('Legs'),
		'Eyes': find_node('Eyes')
	}

func _process(delta):
	if Globals.selected_sacrifice != selected_sacrifice:
		selected_sacrifice = Globals.selected_sacrifice
		
		for sacrifice in sacrifices.values():
			if sacrifice.name == selected_sacrifice:
				sacrifice.show()
			else:
				sacrifice.hide()
			

func _on_hero_hit():
	health -= 1
	var icon = health_icons.pop_back()
	icon.hide()

