class_name Cinema extends Building

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite = $Cinema
	body = $Collider
	need_type = Dude.NeedType.Entertainment
	super._ready()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
