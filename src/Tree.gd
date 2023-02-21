extends Node3D

class_name PolyTree

func _ready():
	add_child(Branch.new(Leaves.new(2)))
