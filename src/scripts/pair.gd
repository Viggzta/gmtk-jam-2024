class_name Pair extends Resource

var needs_array: Array[Dude.NeedType]
var count: int

func _init(array: Array[Dude.NeedType], count: int) -> void:
	self.needs_array = array
	self.count = count
