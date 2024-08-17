class_name House extends Building

func _ready() -> void:
	need_type = Dude.NeedType.HouseWalk
	sprite = $House
	body = $Collider
	super._ready()
