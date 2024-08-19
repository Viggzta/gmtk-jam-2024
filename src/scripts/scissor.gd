extends Node2D
@onready var scissor_closed: Sprite2D = $ScissorClosed
@onready var scissor_open: Sprite2D = $ScissorOpen

var rope_that_is_touched:Area2D 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_set_to_visible(scissor_open)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("left_mouse_click"):
		_set_to_visible(scissor_closed)
	else:
		_set_to_visible(scissor_open)
		
	if Input.is_action_just_pressed("left_mouse_click"):
		_cut()
		
	global_position = get_global_mouse_position()
	
func _set_to_visible(scissor_image :Sprite2D)->void:
	scissor_closed.visible = false
	scissor_open.visible = false
	scissor_image.visible = true
	
func _cut()-> void:
	if rope_that_is_touched != null:
		print("cut")
		rope_that_is_touched.get_parent().queue_free()
	else:
		print("cant cut")


func _on_area_2d_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	rope_that_is_touched = area


func _on_area_2d_area_shape_exited(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	rope_that_is_touched = null
