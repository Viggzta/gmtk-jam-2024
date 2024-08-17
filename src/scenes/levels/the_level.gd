extends Node2D

const HOUSE = preload("res://scenes/buildings/house.tscn")
const DUDE = preload("res://scenes/npc/dude.tscn")

@onready var dude_root: Node2D = $DudeRoot
@onready var building_root: Node2D = $Navmesh/BuildingRoot
@onready var navmesh: NavigationRegion2D = $Navmesh

@export var buildable_radius: float = 2.5
@export var building_offset: int = 256
@export var dude_spawn_offset: float = 50.0

var building_spots: Dictionary = {}
var current_max_radius: float;

func _create_build_spots(radius: float) -> void:
	for x: int in range(-radius, radius + 1):
		for y: int in range(-radius, radius + 1):
			var length: float = Vector2(x, y).length()
			if length < radius:
				var new_pos: Vector2 = Vector2(x * building_offset, y * building_offset)
				if !building_spots.has(new_pos):
					var house: Building = HOUSE.instantiate()
					house.position = new_pos
					building_spots[new_pos] = house
					building_root.add_child(house)
	if current_max_radius < radius:
		current_max_radius = radius
	navmesh.bake_navigation_polygon()

func _ready() -> void:
	_create_build_spots(buildable_radius)
	_spawn_wave(250)
	
func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.keycode == KEY_B:
			_spawn_wave(10)
	
func _spawn_wave(amount: int) -> void:
	print(current_max_radius)
	for i in range(0, amount):
		var spawn_location_radians: float = randf() * TAU
		var spawn_location: Vector2 = Vector2( 
			cos(spawn_location_radians) * current_max_radius * building_offset + cos(spawn_location_radians) * dude_spawn_offset,
			sin(spawn_location_radians) * current_max_radius * building_offset + sin(spawn_location_radians) * dude_spawn_offset)
		var dude: Node2D = DUDE.instantiate()
		dude.initialize(spawn_location, [Dude.NeedType.Poop], building_root)
		dude_root.add_child(dude)
	
