extends Node

var _sound_fx_volume: float = 1.0
var _music_volume: float = 1.0

var _music_bus_name: String = "Music"
var _fx_bus_name: String = "FX"

var dude_count: int = 0
var total_needs: int = 0 
var current_day :int = 0

enum GameState { Setup, Rush, Failure, Success }
var current_state: GameState = GameState.Setup
var current_building_type: BuildingType.Type


var level_restrictions: Dictionary = {
	1 : {BuildingType.Type.ShitHouse : 2, BuildingType.Type.Donken : 1},
	2 : {BuildingType.Type.ShitHouse : 4, BuildingType.Type.Donken : 4},
	3 : {BuildingType.Type.ShitHouse : 4, BuildingType.Type.Donken : 4},
	4 : {BuildingType.Type.ShitHouse : 4, BuildingType.Type.Donken : 4},
	5 : {BuildingType.Type.ShitHouse : 4, BuildingType.Type.Donken : 4},
	6 : {BuildingType.Type.ShitHouse : 4, BuildingType.Type.Donken : 4},
	7 : {BuildingType.Type.ShitHouse : 4, BuildingType.Type.Donken : 4},
	8 : {BuildingType.Type.ShitHouse : 4, BuildingType.Type.Donken : 4},
	9 : {BuildingType.Type.ShitHouse : 4, BuildingType.Type.Donken : 4},
	10 : {BuildingType.Type.ShitHouse : 4, BuildingType.Type.Donken : 4},
	11 : {BuildingType.Type.ShitHouse : 4, BuildingType.Type.Donken : 4},
	12 : {BuildingType.Type.ShitHouse : 4, BuildingType.Type.Donken : 4},
	13 : {BuildingType.Type.ShitHouse : 4, BuildingType.Type.Donken : 4},
	14 : {BuildingType.Type.ShitHouse : 4, BuildingType.Type.Donken : 4},
	15 : {BuildingType.Type.ShitHouse : 4, BuildingType.Type.Donken : 4},
	16 : {BuildingType.Type.ShitHouse : 4, BuildingType.Type.Donken : 4},
	17 : {BuildingType.Type.ShitHouse : 4, BuildingType.Type.Donken : 4},
	18 : {BuildingType.Type.ShitHouse : 4, BuildingType.Type.Donken : 4},
	19 : {BuildingType.Type.ShitHouse : 4, BuildingType.Type.Donken : 4},
	20 : {BuildingType.Type.ShitHouse : 4, BuildingType.Type.Donken : 4},
	21 : {BuildingType.Type.ShitHouse : 4, BuildingType.Type.Donken : 4},
	22 : {BuildingType.Type.ShitHouse : 4, BuildingType.Type.Donken : 4},
	23 : {BuildingType.Type.ShitHouse : 4, BuildingType.Type.Donken : 4},
	24 : {BuildingType.Type.ShitHouse : 4, BuildingType.Type.Donken : 4},
	25 : {BuildingType.Type.ShitHouse : 4, BuildingType.Type.Donken : 4},
	26 : {BuildingType.Type.ShitHouse : 4, BuildingType.Type.Donken : 4},
	27 : {BuildingType.Type.ShitHouse : 4, BuildingType.Type.Donken : 4},
	28 : {BuildingType.Type.ShitHouse : 4, BuildingType.Type.Donken : 4},
	29 : {BuildingType.Type.ShitHouse : 4, BuildingType.Type.Donken : 4},
	30 : {BuildingType.Type.ShitHouse : 4, BuildingType.Type.Donken : 4}
}

@onready var _music_bus := AudioServer.get_bus_index(_music_bus_name)
@onready var _fx_bus := AudioServer.get_bus_index(_fx_bus_name)


var sound_fx_volume: float:
	get:
		return AudioServer.get_bus_volume_db(_fx_bus)
	set(value):
		_sound_fx_volume = value
		print("FX: " + str(value))
		AudioServer.set_bus_volume_db(_fx_bus, linear_to_db(_sound_fx_volume))
		
var music_volume: float:
	get:
		return AudioServer.get_bus_volume_db(_music_bus)
	set(value):
		_music_volume = value
		print("Music: " + str(value))
		AudioServer.set_bus_volume_db(_music_bus, linear_to_db(_music_volume))
