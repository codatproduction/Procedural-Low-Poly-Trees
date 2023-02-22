extends Node3D

var tree = null

func _ready():
	showcase_1()

func showcase_1():
	tree = PolyTree.new()
	add_child(tree)
	
	var timer = Timer.new()
	timer.wait_time = 0.65
	timer.timeout.connect(self._on_timer_timeout)
	add_child(timer)
	timer.start()


func _on_timer_timeout():
	tree.queue_free()
	tree = PolyTree.new()
	add_child(tree)
