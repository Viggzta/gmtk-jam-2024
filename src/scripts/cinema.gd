class_name Cinema extends Building

func _ready() -> void:
	sprite = $Cinema
	body = $Collider
	need_type = Dude.NeedType.Entertainment
	super._ready()
