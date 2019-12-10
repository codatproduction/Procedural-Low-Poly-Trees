extends Spatial

var tree = null

func _ready():
	showcase_1()
	
func showcase_1():
	tree = PolyTree.new()
	add_child(tree)
	
	var timer = Timer.new()
	timer.wait_time = 0.65
	timer.connect("timeout", self, "_on_Timer_timeout")
	add_child(timer)
	timer.start()


func _on_Timer_timeout():
	tree.queue_free()
	tree = PolyTree.new()
	add_child(tree)
