class_name Cinema extends Building

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite = $Hospital
	body = $Collider
	need_type = Dude.NeedType.Eat

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
