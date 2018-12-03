extends Area2D

var player
var action

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	action = self.name.replace('Attack', '').to_lower()

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func on_attack_enter(area):
	if 'Enemy1' in area.name && action == Globals.player_attack_direction:
		Globals.killable_enemies.append(area)


func on_attack_exit(area):
	if 'Enemy1' in area.name:
		Globals.killable_enemies.erase(area)


func _on_AttackRight_area_entered( area ):
	on_attack_enter(area)


func _on_AttackRight_area_exited( area ):
	on_attack_exit(area)

	
func _on_AttackLeft_area_entered( area ):
	on_attack_enter(area)


func _on_AttackLeft_area_exited( area ):
	on_attack_exit(area)
	
	
func _on_AttackDown_area_entered( area ):
	on_attack_enter(area)


func _on_AttackDown_area_exited( area ):
	on_attack_exit(area)
	
	
func _on_AttackUp_area_entered( area ):
	on_attack_enter(area)


func _on_AttackUp_area_exited( area ):
	on_attack_exit(area)
