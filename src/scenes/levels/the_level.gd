extends Node2D

@export var buildable_radius: float = 2.5
@export var building_offset: int = 256
var building_spots: Dictionary = {}
const HOUSE = preload("res://scenes/buildings/house.tscn")

func _create_build_spots(radius: float) -> void:
	for x: int in range(-radius, radius + 1):
		for y: int in range(-radius, radius + 1):
			var length: float = Vector2(x, y).length()
			if length < radius:
				var new_pos: Vector2 = Vector2(x * building_offset, y * building_offset)
				if !building_spots.has(new_pos):
					var house: Node2D = HOUSE.instantiate()
					house.position = new_pos
					building_spots[new_pos] = house
					add_child(house)

func _ready() -> void:
	_create_build_spots(buildable_radius)
