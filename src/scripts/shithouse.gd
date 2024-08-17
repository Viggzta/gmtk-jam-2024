class_name ShitHouse extends Building

func _ready() -> void:
	need_type = Dude.NeedType.Poop
	sprite = $"Baja-maja"
	body = $StaticBody2D
	super._ready()
