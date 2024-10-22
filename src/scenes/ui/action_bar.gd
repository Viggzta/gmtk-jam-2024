class_name ActionBar extends Control

@onready var action_buttons: Control = $ActionButtons
const ACTION_BUTTON = preload("res://scenes/ui/action_button.tscn")
const BAJA_MAJA = preload("res://art/buildings/baja-maja.png")
const HOUSE = preload("res://art/buildings/house3.png")
const DONKEN = preload("res://art/buildings/donken.png")
const HOSPITAL = preload("res://art/buildings/hospital.png")
const CINEMA = preload("res://art/buildings/cinema.png")
const NITECLUB = preload("res://art/buildings/nite_club_still.png")

@export var button_offset: float = 100. 

func _ready() -> void:
	_init_building_button(BAJA_MAJA, BuildingType.Type.ShitHouse)
	_init_building_button(DONKEN, BuildingType.Type.Donken)
	_init_building_button(HOSPITAL, BuildingType.Type.Hospital)
	_init_building_button(CINEMA, BuildingType.Type.Cinema)
	_init_building_button(NITECLUB, BuildingType.Type.NiteClub)

	
func _init_building_button(resource : Resource, building_type : BuildingType.Type) -> void:
	var ab: ActionButton = ACTION_BUTTON.instantiate()
	ab.initialize(resource, building_type, self)
	action_buttons.add_child(ab)

func set_building_count(building_type: BuildingType.Type, count:int) -> void:
	for action_btn: ActionButton in action_buttons.get_children():
		if action_btn.building_type == building_type:
			action_btn.set_level_count(count)
			
func reset_selection() -> void:
	for action_btn: ActionButton in action_buttons.get_children():
		action_btn.is_selected = false

func reset_all_building_count() -> void:
	for action_btn: ActionButton in action_buttons.get_children():
		action_btn.set_level_count(0)
