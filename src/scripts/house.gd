class_name House extends Building

func _ready() -> void:
	need_type = Dude.NeedType.Eat
	sprite = $House
	body = $Collider
	shape = $Collider/CollisionShape2D.shape
	super._ready()
