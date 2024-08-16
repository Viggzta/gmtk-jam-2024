extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	call_deferred("test")
	pass # Replace with function body.

func test():
	
	print("baking...")
	var new_navigation_map: RID = NavigationServer2D.map_create()
	NavigationServer2D.map_set_active(new_navigation_map, true)
	
	NavigationServer2D.bake_from_source_geometry_data($NavigationRegion2D.navigation_polygon, NavigationMeshSourceGeometryData2D.new());


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_left"):
		var pos = get_global_mouse_position()
		$Dude/RigidBody2D/NavigationAgent2D.target_position = pos
		$Dude2/RigidBody2D/NavigationAgent2D.target_position = pos
		$Dude3/RigidBody2D/NavigationAgent2D.target_position = pos
		$Dude4/RigidBody2D/NavigationAgent2D.target_position = pos
		$Dude5/RigidBody2D/NavigationAgent2D.target_position = pos
		print("moving to: ", pos)
	pass
