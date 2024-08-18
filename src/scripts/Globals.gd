extends Node

var _sound_fx_volume: float = 1.0
var _music_volume: float = 1.0

var _music_bus_name: String = "Music"
var _fx_bus_name: String = "FX"

var dude_count: int = 0
var total_needs: int = 0 
var current_day :int = 1
var camera_shake: float = 0

enum GameState { Setup, Rush, Failure, Success }
var current_state: GameState = GameState.Setup
var current_building_type: BuildingType.Type


var level_restrictions: Dictionary = {
	1 : {BuildingType.Type.ShitHouse : 0, BuildingType.Type.Donken : 1, BuildingType.Type.Cinema : 1},
	2 : {BuildingType.Type.ShitHouse : 2, BuildingType.Type.Donken : 0},
	3 : {BuildingType.Type.ShitHouse : 4, BuildingType.Type.Donken : 4},
	4 : {BuildingType.Type.ShitHouse : 4, BuildingType.Type.Donken : 2},
	5 : {BuildingType.Type.ShitHouse : 4, BuildingType.Type.Donken : 4},
	6 : {BuildingType.Type.ShitHouse : 4, BuildingType.Type.Donken : 4},
	7 : {BuildingType.Type.ShitHouse : 4, BuildingType.Type.Donken : 4},
	8 : {BuildingType.Type.ShitHouse : 4, BuildingType.Type.Donken : 4},
	9 : {BuildingType.Type.ShitHouse : 4, BuildingType.Type.Donken : 4},
	10 : {BuildingType.Type.ShitHouse : 4, BuildingType.Type.Donken : 4},
}

var level_needs: Dictionary = {
	1 : [
		Pair.new([Dude.NeedType.Eat], 80),
	],
	2 : [
		Pair.new([Dude.NeedType.Poop], 100),
	],
	3 : [
		Pair.new([Dude.NeedType.Eat], 80),
		Pair.new([Dude.NeedType.Poop], 80),
	],
	4 : [
		Pair.new([Dude.NeedType.Eat, Dude.NeedType.Poop], 160),
	],
	5 : [
		Pair.new([Dude.NeedType.Eat, Dude.NeedType.Poop], 100),
		Pair.new([Dude.NeedType.Poop], 100),
	],
	6 : [
		Pair.new([Dude.NeedType.Eat, Dude.NeedType.Poop], 120),
		Pair.new([Dude.NeedType.Poop], 120),
	],
	7 : [
		Pair.new([Dude.NeedType.Eat, Dude.NeedType.Poop], 140),
		Pair.new([Dude.NeedType.Poop], 140),
	],
	8 : [
		Pair.new([Dude.NeedType.Eat, Dude.NeedType.Poop], 160),
		Pair.new([Dude.NeedType.Poop], 160),
	],
	9 : [
		Pair.new([Dude.NeedType.Eat, Dude.NeedType.Poop], 180),
		Pair.new([Dude.NeedType.Poop], 180),
	],
	10 : [
		Pair.new([Dude.NeedType.Eat, Dude.NeedType.Poop], 200),
		Pair.new([Dude.NeedType.Poop], 200),
	],
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
