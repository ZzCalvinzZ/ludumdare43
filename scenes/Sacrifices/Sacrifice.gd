extends Node2D

# class member variables go here, for example:
export (bool) var highlighted = false
export (float) var intensity_increment = 1
var light

var MIN_LIGHT_INTENSITY = 1.5
var MAX_LIGHT_INTENSITY = 2
var light_intensity = MAX_LIGHT_INTENSITY
var light_intensity_dir = 1

func _ready():
	light = get_node("Light2D")

func _process(delta):
	if highlighted:
		light.energy = light_intensity
		
		light_intensity += light_intensity_dir * delta * intensity_increment
		
		if light_intensity > MAX_LIGHT_INTENSITY:
			light_intensity_dir = -1
		elif light_intensity < MIN_LIGHT_INTENSITY:
			light_intensity_dir = 1
	else:
		light.energy = 0