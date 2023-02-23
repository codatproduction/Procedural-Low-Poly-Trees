extends Node3D

var rotate = true

func _process(delta):
	if rotate:
		rotate_y(delta * 0.3)
