extends Node2D
@onready var scissor_closed: Sprite2D = $ScissorClosed
@onready var scissor_open: Sprite2D = $ScissorOpen

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_set_to_visible(scissor_open)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("left_mouse_click"):
		_set_to_visible(scissor_closed)
	else:
		_set_to_visible(scissor_open)
		
	global_position = get_global_mouse_position()
	
func _set_to_visible(scissor_image :Sprite2D)->void:
	scissor_closed.visible = false
	scissor_open.visible = false
	scissor_image.visible = true
