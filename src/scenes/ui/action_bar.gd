extends Control

@onready var action_buttons: Control = $ActionButtons
const ACTION_BUTTON = preload("res://scenes/ui/action_button.tscn")
const BAJA_MAJA = preload("res://art/buildings/baja-maja.png")
const HOUSE = preload("res://art/buildings/house3.png")
const DONKEN = preload("res://art/buildings/donken.png")

@export var button_offset: float = 100. 

func _ready() -> void:
	_init_building_button(BAJA_MAJA, BuildingType.Type.ShitHouse)
	_init_building_button(HOUSE, BuildingType.Type.House)
	_init_building_button(DONKEN, BuildingType.Type.Donken)
	
func _init_building_button(resource : Resource, building_type : BuildingType.Type) -> void:
	var ab: ActionButton = ACTION_BUTTON.instantiate()
	ab.initialize(resource, building_type)
	action_buttons.add_child(ab)

func set_building_count(donken:int, shithouse:int) -> void:
	for action_btn: ActionButton in action_buttons.get_children():
		if(action_btn.building_type == BuildingType.Type.ShitHouse):
			action_btn.set_level_count(shithouse)
		elif(action_btn.building_type == BuildingType.Type.Donken):
			action_btn.set_level_count(donken)

func set_donken_count(count:int) -> void:
	for action_btn: ActionButton in action_buttons.get_children():
		if(action_btn.building_type == BuildingType.Type.Donken):
			action_btn.set_level_count(count)

func set_shithouse_count(count:int) -> void:
	for action_btn: ActionButton in action_buttons.get_children():
		if(action_btn.building_type == BuildingType.Type.ShitHouse):
			action_btn.set_level_count(count)
