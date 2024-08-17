extends Node

var _sound_fx_volume: float = 1.0
var _music_volume: float = 1.0

var _music_bus_name: String = "Music"
var _fx_bus_name: String = "FX"

var dude_count: int = 0

enum GameState { Setup, Rush, Failure, Success }
var current_state: GameState = GameState.Setup
var current_building_type: BuildingType.Type


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
