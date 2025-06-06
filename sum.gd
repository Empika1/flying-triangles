extends Node

func _init() -> void:
	var s = Summator.new()
	s.add_one()
	s.add(10)
	s.add(20)
	s.add(30)
	print(s.get_total())
	s.reset()
