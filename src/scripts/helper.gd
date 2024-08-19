class_name Helper

const POOP = preload("res://art/emojjis/poop.tres")
const WINE = preload("res://art/emojjis/wine.tres")
const FOOD = preload("res://art/turkey/turkey.png")
const MEDIC = preload("res://art/emojjis/medic.tres")
const CLUBBIN = preload("res://art/emojjis/clubbin.tres")
static func get_texture_for_need(nt: Dude.NeedType) -> Texture2D:
	match nt:
		Dude.NeedType.Poop:
			return POOP
		Dude.NeedType.Eat:
			return FOOD
		Dude.NeedType.MedicalCare:
			return MEDIC
		Dude.NeedType.Entertainment:
			return CLUBBIN
		_:
			return WINE
