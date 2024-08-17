class_name Need extends Node

enum NeedType {Poop, Eat}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func choose_need() -> NeedType:
	return randi_range(0,1) as NeedType
	
func get_need_location(dude: Node, needtype: NeedType, node: Node) -> Vector2:
	var nodes: Array
	var navmesh: Node = node.get_node("Navmesh")
	for child in navmesh.get_children():
		
		if child is ShitHouse: #TODO: ADD NEEDTYPE
			nodes.append(child)
		#TODO: add other buildings
		
	var closestNode: Node2D
	
	for SHITnODE: Node2D in nodes:
		if closestNode == null:
			closestNode = SHITnODE
			
		if SHITnODE.global_position.distance_to(dude.global_position) < closestNode.global_position.distance_to(dude.global_position):
			closestNode = SHITnODE
	
	return closestNode.global_position
	# loop through childrens, check if their type is what we need for our needtype
	# find closest by distance
	# return position of closest
	
