extends Node2D
@onready var timer: Timer = $Timer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.timeout.connect(_on_timer_end)
	timer.start(4+randf()*3)
	pass # Replace with function body.

func _on_timer_end() -> void:
	queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
