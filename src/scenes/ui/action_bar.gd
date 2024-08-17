extends Control

@onready var action_buttons: Control = $ActionButtons
const ACTION_BUTTON = preload("res://scenes/ui/action_button.tscn")
const BAJA_MAJA = preload("res://art/buildings/baja-maja.png")

@export var button_offset: float = 100. 

func _ready() -> void:
	var ab: ActionButton = ACTION_BUTTON.instantiate()
	ab.initialize(BAJA_MAJA, BuildingType.Type.ShitHouse)
	action_buttons.add_child(ab)
