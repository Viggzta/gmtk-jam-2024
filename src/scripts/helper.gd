class_name Helper

const POOP = preload("res://art/emojjis/poop.tres")
const WINE = preload("res://art/emojjis/wine.tres")
const FOOD = preload("res://art/emojjis/food.tres")
const MEDIC = preload("res://art/emojjis/medic.tres")

static func get_texture_for_need(nt: Dude.NeedType) -> Texture2D:
	match nt:
		Dude.NeedType.Poop:
			return POOP
		Dude.NeedType.Eat:
			return FOOD
		Dude.NeedType.MedicalCare:
			return MEDIC
		_:
			return WINE
