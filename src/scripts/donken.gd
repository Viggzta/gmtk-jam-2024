class_name Donken extends Building

func _ready() -> void:
	sprite = $Donken
	body = $Collider
	need_type = Dude.NeedType.Eat
	super._ready()
