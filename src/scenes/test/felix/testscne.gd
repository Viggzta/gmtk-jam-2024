extends Node2D

const DUDE = preload("res://scenes/npc/dude.tscn")

var dudes: Array = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	call_deferred("test")
	for i in range(0, 100):
		var dude: Node = DUDE.instantiate()
		dudes.append(dude)
		add_child(dude)
	pass # Replace with function body.

func test() -> void:
	print("baking...")
	var new_navigation_map: RID = NavigationServer2D.map_create()
	NavigationServer2D.map_set_active(new_navigation_map, true)
	NavigationServer2D.bake_from_source_geometry_data($Navmesh.navigation_polygon, NavigationMeshSourceGeometryData2D.new());


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		var pos: Vector2 = get_global_mouse_position()
		for dude: Node in dudes:
			dude.set_movement_target(pos)
		print("moving to: ", pos)
	pass
