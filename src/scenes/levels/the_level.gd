extends Node2D

const globals = preload("res://scripts/Globals.gd")

const DUDE = preload("res://scenes/npc/dude.tscn")
const FIRE_AND_FORGET_SOUND = preload("res://scenes/fx/fire_and_forget_sound.tscn")

@onready var dude_root: Node2D = $DudeRoot
@onready var building_root: Node2D = $Navmesh/BuildingRoot
@onready var navmesh: NavigationRegion2D = $Navmesh
@onready var background_rect: ColorRect = $BackgroundControl/ColorRectPlatform
@onready var water_rect: ColorRect = $BackgroundControl/ColorRectWater
@onready var fog_rect: ColorRect = $BackgroundControl/ColorRectFog
@onready var upcoming_needs_ui: Control = $CanvasLayer/UpcomingNeedsUi


@onready var debug_window: Control = $CanvasLayer/DebugWindow


@export var buildable_radius: float = 2
@export var building_offset: int = 256
@export var dude_spawn_offset: float = 50.0
@export var platform_extra_offset: float = 80.0

@export var dude_increase_multiply : float = 1.2
@export var build_radius_increase_addition : float = 0.5

var current_day: int = 1
signal new_day(day: int)

var buildings_placed: Dictionary = {}

var building_spots: Dictionary = {}
var current_max_radius: float;
var building_map: Dictionary = {
	BuildingType.Type.House:preload("res://scenes/buildings/house.tscn"),
	BuildingType.Type.ShitHouse:preload("res://scenes/buildings/shithouse.tscn"),
	BuildingType.Type.Donken:preload("res://scenes/buildings/donken.tscn"),
	BuildingType.Type.Cinema:preload("res://scenes/buildings/cinema.tscn"),
 }
var dude_amount : int = 80

func house_clicked(building: Building) -> void:
	if Globals.current_state != Globals.GameState.Setup:
		return
		
	if !building.is_replaceable || building.building_type != BuildingType.Type.House:
		var sound: FireAndForgetSound = FIRE_AND_FORGET_SOUND.instantiate()
		sound.set_and_play(FireAndForgetSound.SoundClips.Uuuh)
		building.add_child(sound)
		return
	
	var current_day_restrictions: Dictionary = Globals.level_restrictions[current_day]
	var max_allowed_count: int = 0
	if current_day_restrictions.has(Globals.current_building_type):
		max_allowed_count = Globals.level_restrictions[current_day][Globals.current_building_type]
	var current_count: int = 0
	if buildings_placed.has(Globals.current_building_type):
		current_count = buildings_placed[Globals.current_building_type]
	else:
		buildings_placed[Globals.current_building_type] = 0
	if current_count >= max_allowed_count:
		return
	
	buildings_placed[Globals.current_building_type] += 1
	var new_current_count: int = buildings_placed[Globals.current_building_type]
	$CanvasLayer/ActionBar.set_building_count(Globals.current_building_type, max_allowed_count - new_current_count)

	var house_resource: Resource = building_map[Globals.current_building_type]
	var house : Building = house_resource.instantiate()
	house.initialize(building.position, Globals.current_building_type)
	house.pressed.connect(house_clicked)
	house.right_pressed.connect(house_right_clicked)
	building_spots[building.position] = house
	building_root.add_child(house)
	building_root.remove_child(building)
	
	var sound: FireAndForgetSound = FIRE_AND_FORGET_SOUND.instantiate()
	sound.set_and_play(FireAndForgetSound.SoundClips.Woosh)
	house.add_child(sound)
	pass
	
func house_right_clicked(building: Building) -> void:
	if !building.is_replaceable || Globals.current_state != Globals.GameState.Setup:
		return
	
	var basic_building_type: BuildingType.Type = BuildingType.Type.House
	if building.building_type == basic_building_type:
		var sound: FireAndForgetSound = FIRE_AND_FORGET_SOUND.instantiate()
		sound.set_and_play(FireAndForgetSound.SoundClips.Uuuh)
		building.add_child(sound)
		return
		
	var current_building_type: BuildingType.Type = building.building_type
	
	var house_resource: Resource = building_map[basic_building_type]
	var house : Building = house_resource.instantiate()
	house.initialize(building.position, basic_building_type)
	house.pressed.connect(house_clicked)
	house.right_pressed.connect(house_right_clicked)
	building_spots[building.position] = house
	building_root.add_child(house)
	building_root.remove_child(building)
	
	buildings_placed[current_building_type] -= 1
	var sound: FireAndForgetSound = FIRE_AND_FORGET_SOUND.instantiate()
	sound.set_and_play(FireAndForgetSound.SoundClips.Suuck)
	house.add_child(sound)
	
	var current_day_restrictions: Dictionary = Globals.level_restrictions[current_day]
	var max_allowed_count: int = 0
	if current_day_restrictions.has(current_building_type):
		max_allowed_count = Globals.level_restrictions[current_day][current_building_type]
	var new_current_count: int = buildings_placed[current_building_type]
	$CanvasLayer/ActionBar.set_building_count(current_building_type, max_allowed_count - new_current_count)

func _create_build_spots(radius: float) -> void:
	for x: int in range(-radius, radius + 1):
		for y: int in range(-radius, radius + 1):
			var length: float = Vector2(x, y).length()
			if length < radius:
				var new_pos: Vector2 = Vector2(x * building_offset, y * building_offset)
				if !building_spots.has(new_pos):
					var house_resource : Resource = building_map[BuildingType.Type.House]
					var house: Building = house_resource.instantiate()
					house.initialize(new_pos, BuildingType.Type.House)
					house.pressed.connect(house_clicked)
					house.right_pressed.connect(house_right_clicked)
					building_spots[new_pos] = house
					building_root.add_child(house)
	if current_max_radius < radius:
		current_max_radius = radius
	navmesh.bake_navigation_polygon()
	var temp_radius: float = radius * building_offset + dude_spawn_offset + platform_extra_offset
	_resize_platform(temp_radius)
	
func _resize_platform(r: float) -> void:
	var r2: float = r + 500.0 

	get_tree().create_tween().tween_property(background_rect, "size", Vector2(r * 2, r * 2), 0.5).set_trans(Tween.TRANS_ELASTIC)
	get_tree().create_tween().tween_property(background_rect, "position", Vector2(-r, -r), 0.5).set_trans(Tween.TRANS_ELASTIC)
	get_tree().create_tween().tween_property(water_rect, "size", Vector2(r2 * 2, r2 * 2), 0.5).set_trans(Tween.TRANS_ELASTIC)
	get_tree().create_tween().tween_property(water_rect, "position", Vector2(-r2, -r2), 0.5).set_trans(Tween.TRANS_ELASTIC)
	get_tree().create_tween().tween_property(fog_rect, "size", Vector2(r2 * 2, r2 * 2), 0.5).set_trans(Tween.TRANS_ELASTIC)
	get_tree().create_tween().tween_property(fog_rect, "position", Vector2(-r2, -r2), 0.5).set_trans(Tween.TRANS_ELASTIC)

func _ready() -> void:
	Globals.current_state = Globals.GameState.Setup
	_create_build_spots(buildable_radius)
	calculate_restrictions()
	buildings_placed = {}
	upcoming_needs_ui.set_level_definition(1)
	
func _spawn_wave() -> void:
	Globals.dude_count = 0
	for level_need: Pair in Globals.level_needs[current_day]:
		for i in range(0, level_need.count):
			var spawn_location_radians: float = randf() * TAU
			var spawn_location: Vector2 = Vector2(
				cos(spawn_location_radians) * current_max_radius * building_offset + cos(spawn_location_radians) * dude_spawn_offset,
				sin(spawn_location_radians) * current_max_radius * building_offset + sin(spawn_location_radians) * dude_spawn_offset)
			_spawn_dude(spawn_location, level_need.needs_array)
		
func _spawn_dude(spawn_location: Vector2, needs: Array[Dude.NeedType]) -> void:
	var dude: Node2D = DUDE.instantiate()
	dude.initialize(spawn_location, needs.duplicate(), building_root)
	dude_root.add_child(dude)
	Globals.dude_count += 1

func _on_hud_pressed() -> void:
	if Globals.current_state == Globals.GameState.Setup:
		_lock_in_all_buildings()
		_spawn_wave()
		_transition_game_state(globals.GameState.Rush)

func _lock_in_all_buildings() -> void:
	for building: Building in building_spots.values():
		if building is not House:
			building.is_replaceable = false

func _transition_game_state(state: globals.GameState) -> void:
	Globals.current_state = state

	if state == globals.GameState.Setup:
		
		current_day += 1
		upcoming_needs_ui.set_level_definition(current_day)

		new_day.emit(current_day)
		$CanvasLayer/SatisfactionUi.visible = false
		Globals.dude_count = 0
		Globals.total_needs = 0
		$CanvasLayer/SatisfactionUi/ProgressBar.value = 100
		buildings_placed.clear()
		calculate_restrictions()
	elif state == globals.GameState.Rush:
		$CanvasLayer/SatisfactionUi.visible = true
	elif state== globals.GameState.Failure:
		current_day = 1
		Globals.total_needs = 0
		upcoming_needs_ui.set_level_definition(1)
		get_tree().change_scene_to_file("res://scenes/levels/the_level.tscn")
	elif state == globals.GameState.Success:
		buildable_radius += build_radius_increase_addition
		dude_amount *= dude_increase_multiply
		_create_build_spots(buildable_radius)
		if(Globals.current_day == 10):
			$CanvasLayer/WinScreen.show_screen()
			get_tree().paused = true
		else:
			_transition_game_state(globals.GameState.Setup)


func _on_satisfaction_ui_lose() -> void:
	$CanvasLayer/FailureScreen.show_screen()
	get_tree().paused = true


func _on_satisfaction_ui_win() -> void:
	_transition_game_state(globals.GameState.Success)

func calculate_restrictions() -> void:
	var level_restriction: Dictionary = Globals.level_restrictions[current_day]
	for b: BuildingType.Type in level_restriction.keys():
		var max_available: int = Globals.level_restrictions[current_day][b]
		$CanvasLayer/ActionBar.set_building_count(b, max_available)
	
func _update_day_globally() -> void:
	Globals.current_day = current_day
	

func _on_failure_screen_pressed_try_again() -> void:
	_transition_game_state(globals.GameState.Failure)
	
func _process(delta: float) -> void:
	_debug_logic()
	
	
	
func _debug_logic()->void:
	if Input.is_key_pressed(KEY_B):
		debug_window.visible = !debug_window.visible
	
	var text:String = "DEBUG WINDOW\n"
	text += "Dudes: '" + str(Globals.dude_count) + "'" + "\n"
	text += "Total needs: '" + str(Globals.total_needs) + "'" + "\n"
	text += "Music volume: '" + str(Globals.music_volume) + "'" + "\n"
	text += "SFX volume: '" + str(Globals.sound_fx_volume) + "'" + "\n"
	text += "Current day: '" + str(Globals.current_day) + "'" + "\n"
	text += "Current state: '" + str(Globals.current_state) +"'" + "\n"
	debug_window.get_child(0).text = text


func _on_win_screen_pressed_play_again() -> void:
	_transition_game_state(globals.GameState.Failure)
