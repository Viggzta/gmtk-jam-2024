class_name Hospital extends Building

func _ready() -> void:
	sprite = $Hospital
	body = $Collider
	need_type = Dude.NeedType.Eat
	super._ready()
