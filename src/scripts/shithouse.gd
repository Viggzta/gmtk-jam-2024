class_name ShitHouse extends Building

func _ready() -> void:
	need_type = Dude.NeedType.Poop
	sprite = $"Baja-maja"
	body = $StaticBody2D
	var col_shape: CollisionShape2D = $StaticBody2D/CollisionShape2D
	var rec: RectangleShape2D = col_shape.shape
	shape = rec
	super._ready()
