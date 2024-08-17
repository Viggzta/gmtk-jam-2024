extends Node2D

const globals = preload("res://scripts/Globals.gd")

const DUDE = preload("res://scenes/npc/dude.tscn")

@onready var dude_root: Node2D = $DudeRoot
@onready var building_root: Node2D = $Navmesh/BuildingRoot
@onready var navmesh: NavigationRegion2D = $Navmesh
@onready var background_rect: ColorRect = $BackgroundControl/ColorRect


@export var buildable_radius: float = 2.5
@export var building_offset: int = 256
@export var dude_spawn_offset: float = 50.0
@export var platform_extra_offset: float = 80.0

@export var dude_increase_multiply : float = 1.2
@export var build_radius_increase_addition : float = 0.5

var current_day: int = 1
signal new_day(day: int)

var building_spots: Dictionary = {}
var current_max_radius: float;
var building_map: Dictionary = {
	BuildingType.Type.House:preload("res://scenes/buildings/house.tscn"),
	BuildingType.Type.ShitHouse:preload("res://scenes/buildings/shithouse.tscn"),
	BuildingType.Type.Donken:preload("res://scenes/buildings/donken.tscn"),
 }
var dude_amount : int = 100

func house_clicked(building: Building) -> void:
	if !building.is_replaceable || Globals.current_state != Globals.GameState.Setup:
		return
	var house_resource: Resource = building_map[Globals.current_building_type]
	var house : Building = house_resource.instantiate()
	house.initialize(building.position)
	house.pressed.connect(house_clicked)
	building_spots[building.position] = house
	building_root.add_child(house)
	building_root.remove_child(building)
	pass

func _create_build_spots(radius: float) -> void:
	for x: int in range(-radius, radius + 1):
		for y: int in range(-radius, radius + 1):
			var length: float = Vector2(x, y).length()
			if length < radius:
				var new_pos: Vector2 = Vector2(x * building_offset, y * building_offset)
				if !building_spots.has(new_pos):
					var house_resource : Resource = building_map[BuildingType.Type.House]
					var house: Building = house_resource.instantiate()
					house.initialize(new_pos)
					house.pressed.connect(house_clicked)
					building_spots[new_pos] = house
					building_root.add_child(house)
	if current_max_radius < radius:
		current_max_radius = radius
	navmesh.bake_navigation_polygon()
	var temp_radius: float = radius * building_offset + dude_spawn_offset + platform_extra_offset
	background_rect.position = Vector2(-temp_radius, -temp_radius)
	background_rect.size = Vector2(temp_radius * 2, temp_radius * 2)

func _ready() -> void:
	Globals.current_state = Globals.GameState.Setup
	_create_build_spots(buildable_radius)
	
func _spawn_wave(amount: int) -> void:
	$"/root/Globals".dude_count = amount
	print(current_max_radius)
	for i in range(0, amount):
		var spawn_location_radians: float = randf() * TAU
		var spawn_location: Vector2 = Vector2( 
			cos(spawn_location_radians) * current_max_radius * building_offset + cos(spawn_location_radians) * dude_spawn_offset,
			sin(spawn_location_radians) * current_max_radius * building_offset + sin(spawn_location_radians) * dude_spawn_offset)
		var dude: Node2D = DUDE.instantiate()
		dude.initialize(spawn_location, [Dude.NeedType.Eat, Dude.NeedType.Poop], building_root)
		dude_root.add_child(dude)

func _on_hud_pressed() -> void:
	if Globals.current_state == Globals.GameState.Setup:
		_lock_in_all_buildings()
		_spawn_wave(dude_amount)
		_transition_game_state(globals.GameState.Rush)

func _lock_in_all_buildings() -> void:
	for building: Building in building_spots.values():
		if building is not House:
			building.is_replaceable = false

func _transition_game_state(state: globals.GameState) -> void:
	$"/root/Globals".current_state = state
	
	if state == globals.GameState.Setup:
		current_day += 1
		new_day.emit(current_day)
		$CanvasLayer/SatisfactionUi.visible = false
		$"/root/Globals".dude_count = 0
		$CanvasLayer/SatisfactionUi/ProgressBar.value = 100
	elif state == globals.GameState.Rush:
		$CanvasLayer/SatisfactionUi.visible = true
	elif state== globals.GameState.Failure:
		current_day = 1
		get_tree().change_scene_to_file("res://scenes/levels/the_level.tscn")
	elif state == globals.GameState.Success:
		buildable_radius += build_radius_increase_addition
		dude_amount *= dude_increase_multiply
		_create_build_spots(buildable_radius)
		_transition_game_state(globals.GameState.Setup)


func _on_satisfaction_ui_lose() -> void:
	_transition_game_state(globals.GameState.Failure)


func _on_satisfaction_ui_win() -> void:
	_transition_game_state(globals.GameState.Success)
