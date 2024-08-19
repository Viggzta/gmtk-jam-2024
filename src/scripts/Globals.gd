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

var incoming_satisfaction_buff:float = 0


var level_restrictions: Dictionary = {
	1 : {BuildingType.Type.ShitHouse : 0, BuildingType.Type.Donken : 1 },
	2 : {BuildingType.Type.ShitHouse : 2, BuildingType.Type.Donken : 0 },
	3 : {BuildingType.Type.ShitHouse : 0, BuildingType.Type.Donken : 1, BuildingType.Type.Cinema : 1 },
	4 : {BuildingType.Type.ShitHouse : 3, BuildingType.Type.Donken : 2, BuildingType.Type.Hospital : 1  },
	5 : {BuildingType.Type.ShitHouse : 4, BuildingType.Type.Donken : 2, BuildingType.Type.NiteClub : 2 },
	6 : {BuildingType.Type.ShitHouse : 4, BuildingType.Type.Donken : 4, BuildingType.Type.Cinema : 1},
	7 : {BuildingType.Type.ShitHouse : 4, BuildingType.Type.Donken : 4, BuildingType.Type.Hospital : 2 },
	8 : {BuildingType.Type.ShitHouse : 4, BuildingType.Type.Donken : 4, BuildingType.Type.NiteClub : 2 },
	9 : {BuildingType.Type.ShitHouse : 4, BuildingType.Type.Donken : 4, },
	10 : {BuildingType.Type.ShitHouse : 4, BuildingType.Type.Donken : 4 },
}
#1 : {BuildingType.Type.ShitHouse : 0, BuildingType.Type.Donken : 1, BuildingType.Type.Cinema : 1, BuildingType.Type.NiteClub : 1},
var level_needs: Dictionary = {
	1 : [
		Pair.new([Dude.NeedType.Eat], 250),
	],
	2 : [
		Pair.new([Dude.NeedType.Poop], 300),
	],
	3 : [
		Pair.new([Dude.NeedType.Eat], 100),
		Pair.new([Dude.NeedType.Poop], 100),
	],
	4 : [
		Pair.new([Dude.NeedType.Eat, Dude.NeedType.Poop], 90),
		Pair.new([Dude.NeedType.MedicalCare], 30),
	],
	5 : [
		Pair.new([Dude.NeedType.Eat, Dude.NeedType.Poop], 20),
		Pair.new([Dude.NeedType.MedicalCare], 35),
		Pair.new([Dude.NeedType.Entertainment], 45),
	],
	6 : [
		Pair.new([Dude.NeedType.MedicalCare, Dude.NeedType.Poop], 20),
		Pair.new([Dude.NeedType.Entertainment, Dude.NeedType.Eat], 20),
		Pair.new([Dude.NeedType.Eat, Dude.NeedType.Poop], 50),
	],
	7 : [
		Pair.new([Dude.NeedType.Eat, Dude.NeedType.Poop], 90),
		Pair.new([Dude.NeedType.Entertainment, Dude.NeedType.Poop], 10)
	],
	8 : [
		Pair.new([Dude.NeedType.MedicalCare, Dude.NeedType.Poop], 20),
		Pair.new([Dude.NeedType.MedicalCare, Dude.NeedType.Eat], 20),
		Pair.new([Dude.NeedType.Poop, Dude.NeedType.Eat], 50),
		Pair.new([Dude.NeedType.Entertainment], 50),
	],
	9 : [
		Pair.new([Dude.NeedType.MedicalCare, Dude.NeedType.Eat], 20),
		Pair.new([Dude.NeedType.Entertainment, Dude.NeedType.Poop], 20),
		Pair.new([Dude.NeedType.Eat], 50),
		Pair.new([Dude.NeedType.Poop], 50),
	],
	10 : [
		Pair.new([Dude.NeedType.MedicalCare, Dude.NeedType.Poop, Dude.NeedType.Eat], 20),
		Pair.new([Dude.NeedType.Entertainment, Dude.NeedType.Eat, Dude.NeedType.Poop], 30),
		Pair.new([Dude.NeedType.Eat, Dude.NeedType.Poop], 50),
		Pair.new([Dude.NeedType.Poop, Dude.NeedType.Eat], 50),
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
