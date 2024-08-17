class_name Donken extends Building

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite = $Donken
	body = $Collider
	need_type = Dude.NeedType.Eat
	super._ready()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
